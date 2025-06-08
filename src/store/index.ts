// https://github.com/capacitor-community/text-to-speech
import { TextToSpeech, TTSOptions } from '@capacitor-community/text-to-speech';
import { Ref, ref } from 'vue'
import { defineStore } from 'pinia'

import { Storage } from '@ionic/storage';
import i18n from '@/i18n';
import { Button } from '@/models';
const storage = new Storage();

export const useGeneralStore = defineStore('general', () => {
  const sidebarOpen = ref(false)
    async function setSidebarOpen (isOpen: boolean) {
    sidebarOpen.value = isOpen
  }

  const buttonsPreset: Button[] = [
    {
      id: "0",
      text: "Živjo"
    },
    {
      id: "1",
      text: "Kako si?"
    },
    {
      id: "2",
      text: "Vredu sem"
    },
    {
      id: "3",
      text: "Mami"
    },
    {
      id: "4",
      text: "Oči"
    },
    {
      id: "5",
      text: "Lačen sem"
    },
    {
      id: "6",
      text: "Pika"
    },
    {
      id: "7",
      text: "Klemen"
    },
    {
      id: "8",
      text: "Barbara"
    },
    {
      id: "9",
      text: "This is a speech synthesis in English"
    },
  ]
  const buttons: Ref<Button[]> = ref([]);
  function addButton () {
    const newButton: Button = {
      id: Math.random().toString(36).substr(2, 9),
      text: ""
    }
    buttons.value.push(newButton);
    setEditButton(newButton);
    setButtons();
  }

  const editButton: Ref<Button | null> = ref(null);
  function setEditButton (button: Button | null) {
    editButton.value = button
  }

  function updateButton (button: Button) {
    const buttonIndex = buttons.value.findIndex(b => b.id == button.id);
    if (buttonIndex) {
      buttons.value[buttonIndex] = button
    }
    setButtons()
  }

  function removeButton (button: Button) {
    const buttonIndex = buttons.value.findIndex(b => b.id == button.id);
    if (buttonIndex) {
      console.log("[STORE] Remove button:", buttonIndex);
      buttons.value.splice(buttonIndex, 1);
      setButtons()
    }
  }

  async function setButtons () {
    console.log("[STORE] Set buttons:", buttons.value)
    await storage.set('buttons', JSON.stringify(buttons.value));
  }

  async function init () {
    await storage.create();
    language.value = await storage.get('language') || "sl"
    setLanguage(language.value)
    rate.value = await storage.get('rate') || 1.0
    pitch.value = await storage.get('pitch') || 1.0
    voice.value = await storage.get('voice') || "sl-SI"
    buttonsColumns.value = await storage.get('buttons-columns') || 5
    buttonsRows.value = await storage.get('buttons-rows') || 4
    const storageButtons = await storage.get('buttons');
    if (storageButtons) {
      buttons.value = JSON.parse(storageButtons)
    } else {
      buttons.value = buttonsPreset
    }

    // Add buttons to fill the page
    // const numberOfButtonsPerPage = buttonsColumns.value * buttonsRows.value;
    // const buttonsToAdd = numberOfButtonsPerPage - buttons.value.length;
    // for (let i = 0; i < buttonsToAdd; i++) {
    //   const newButton = buttonPreset
    //   newButton.id = Math.random().toString(36).substr(2, 9);
    //   buttons.value.push(newButton)
    // } 
  }

  const languages = [
    { id: "sl", text: "Slovenščina" },
    { id: "en", text: "English" },
  ]
  const language = ref("sl")
  async function setLanguage (lang: string) {
    console.log("[STORE] Set language:", lang)
    await storage.set('language', lang);
    language.value = lang;
    i18n.global.locale.value = lang
  }

  const isEditing = ref(false)
  async function toggleEditing () {
    isEditing.value = !isEditing.value;
    console.log("[STORE] Toggle isEditing:", isEditing);
  }

  const buttonsColumns = ref(5)
  async function setButtonsColumns (value: number) {
    console.log("[STORE] Set buttons columns:", value);
    await storage.set('buttons-columns', value);
    buttonsColumns.value = value
  }

  const buttonsRows = ref(4)
  async function setButtonsRows (value: number) {
    console.log("[STORE] Set buttons rows:", value);
    await storage.set('buttons-rows', value);
    buttonsRows.value = value
  }

  const voice = ref("sl-SI")
  async function setVoice (value: string) {
    console.log("[STORE] Set voice:", value);
    await storage.set('voice', value);
    voice.value = value;
  }

  const pitch = ref(1.0)
  async function setPitch (value: number) {
    console.log("[STORE] Set pitch:", value);
    await storage.set('pitch', value);
    pitch.value = value
  }

  const rate = ref(1.0)
  async function setRate (value: number) {
    console.log("[STORE] Set rate:", value);
    await storage.set('rate', value);
    rate.value = value
  }

  const textToSpeak = ref("")
  const speak = async (text: string) => {
    if (!text) return;
    const options: TTSOptions = {
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
    addButton,
    removeButton,
    buttonsColumns,
    setButtonsColumns,
    buttonsRows,
    setButtonsRows,
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
    setLanguage,
    isEditing,
    toggleEditing,
    editButton,
    setEditButton,
    updateButton,
    textToSpeak
   }
})