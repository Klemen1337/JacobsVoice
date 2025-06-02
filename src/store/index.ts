// https://github.com/capacitor-community/text-to-speech
import { TextToSpeech } from '@capacitor-community/text-to-speech';
import { ref } from 'vue'
import { defineStore } from 'pinia'

import { Storage } from '@ionic/storage';
import i18n from '@/i18n';
const store = new Storage();

export const useGeneralStore = defineStore('general', () => {
  const sidebarOpen = ref(false)
    async function setSidebarOpen (isOpen: boolean) {
    sidebarOpen.value = isOpen
  }

  const buttons = ref([
    {
      id: 0,
      name: "Živjo"
    },
    {
      id: 1,
      name: "Kako si?"
    },
    {
      id: 2,
      name: "Vredu sem"
    },
    {
      id: 3,
      name: "Mami"
    },
    {
      id: 4,
      name: "Oči"
    },
    {
      id: 5,
      name: "Lačen sem"
    },
    {
      id: 6,
      name: "Pika"
    },
    {
      id: 7,
      name: "Klemen"
    },
    {
      id: 8,
      name: "Barbara"
    },
    {
      id: 10,
      name: "This is a speech synthesis in English"
    },
  ])

  async function init () {
    await store.create();
    language.value = await store.get('language') || "sl"
    setLanguage(language.value)
    rate.value = await store.get('rate') || 1.0
    pitch.value = await store.get('pitch') || 1.0
    voice.value = await store.get('voice') || "sl-SI"
  }

  const languages = [
    { id: "sl", name: "Slovenščina" },
    { id: "en", name: "English" },
  ]
  const language = ref("sl")
  async function setLanguage (lang: string) {
    console.log("[STORE] Set language:", lang)
    await store.set('language', lang);
    i18n.global.locale.value = lang
  }

  const voice = ref("sl-SI")
  async function setVoice (value: string) {
    console.log("[STORE] Set voice:", value);
    await store.set('voice', value);
  }

  const pitch = ref(1.0)
  async function setPitch (value: number) {
    console.log("[STORE] Set pitch:", value);
    await store.set('pitch', value);
  }

  const rate = ref(1.0)
  async function setRate (value: number) {
    console.log("[STORE] Set rate:", value);
    await store.set('rate', value);
  }

  const speak = async (text: string) => {
    if (!text) return;
    const options = {
      text: text,
      lang: voice.value,
      rate: Number(rate.value),
      pitch: Number(pitch.value),
      volume: 1.0,
      category: 'playback', //'ambient',
      queueStrategy: 0
    };
    console.log("[STORE] Speak:", options);
    try {
      await TextToSpeech.speak(options);
    } catch(e) {
      console.warn(e);
    }
  };

  return {
    init,
    buttons,
    rate,
    setRate,
    pitch,
    setPitch,
    voice,
    setVoice,
    speak,
    sidebarOpen,
    setSidebarOpen,
    languages,
    language,
    setLanguage
   }
})