const preferredEnglishVoiceNames = [
  'Samantha',
  'Ava',
  'Allison',
  'Alex',
  'Google US English',
  'Microsoft Aria',
  'Microsoft Jenny',
  'Microsoft Guy',
  'Daniel',
  'Karen',
];

const noveltyVoicePattern =
  /albert|bad news|bahh|bells|boing|bubbles|cellos|deranged|grandma|grandpa|hysterical|pipe organ|trinoids|whisper|wobble|zarvox/i;

function getPreferredEnglishVoice(voices: SpeechSynthesisVoice[]) {
  const englishVoices = voices.filter((voice) =>
    voice.lang.toLowerCase().startsWith('en-'),
  );

  return englishVoices
    .filter((voice) => !noveltyVoicePattern.test(voice.name))
    .sort((left, right) => {
      const score = (voice: SpeechSynthesisVoice) => {
        const preferredIndex = preferredEnglishVoiceNames.findIndex((name) =>
          voice.name.toLowerCase().includes(name.toLowerCase()),
        );
        const languageScore = voice.lang.toLowerCase() === 'en-us' ? 300 : 100;
        const preferredScore =
          preferredIndex === -1 ? 0 : 1_000 - preferredIndex * 50;
        const qualityScore = /natural|premium|enhanced/i.test(voice.name)
          ? 150
          : 0;

        return preferredScore + languageScore + qualityScore;
      };

      return score(right) - score(left);
    })[0];
}

async function getSpeechVoices() {
  const voices = window.speechSynthesis.getVoices();

  if (voices.length > 0) {
    return voices;
  }

  return new Promise<SpeechSynthesisVoice[]>((resolve) => {
    const finish = () => {
      window.clearTimeout(timeoutId);
      window.speechSynthesis.removeEventListener('voiceschanged', finish);
      resolve(window.speechSynthesis.getVoices());
    };
    const timeoutId = window.setTimeout(finish, 800);

    window.speechSynthesis.addEventListener('voiceschanged', finish, {
      once: true,
    });
  });
}

export async function pronounceEnglish(text: string) {
  const normalizedText = text.trim();

  if (!normalizedText || !('speechSynthesis' in window)) {
    return;
  }

  const voices = await getSpeechVoices();
  window.speechSynthesis.cancel();

  await new Promise((resolve) => window.setTimeout(resolve, 40));

  const utterance = new SpeechSynthesisUtterance(normalizedText);
  const voice = getPreferredEnglishVoice(voices);

  utterance.lang = 'en-US';
  utterance.rate = 0.88;
  utterance.pitch = 1;
  utterance.volume = 1;

  if (voice) {
    utterance.voice = voice;
    utterance.lang = voice.lang;
  }

  window.speechSynthesis.speak(utterance);
}
