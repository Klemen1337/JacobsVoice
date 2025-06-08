<template>
  <div class="settings-panel" v-if="store.sidebarOpen">
    <div class="settings-panel-overlay" @click="store.setSidebarOpen(false)"></div>
    <div class="settings-panel-inner">
       <!-- <ion-list>
        <ion-list-header>
          <ion-label>Settings</ion-label>
        </ion-list-header>
        <ion-item>
          <ion-toggle>Receive Push Notifications</ion-toggle>
        </ion-item>
        <ion-item>
          <ion-toggle>Receive Emails</ion-toggle>
        </ion-item>
        <ion-item>
          <ion-toggle>Receive Text Messages</ion-toggle>
        </ion-item>
      </ion-list> -->

      <div class="settings">
        <h1>{{ $t("settings.title") }}</h1>

        <!-- Language -->
        <div class="form-group">
          <label>{{ $t("settings.language.title") }} ({{ store.language }})</label>
          <select v-model="store.language" @change="store.setLanguage($event.target?.value)">
            <option v-for="v in store.languages" :key="v.id" :value="v.id">{{ v.name }} ({{ v.id }})</option>
          </select>
          <!-- <ion-select interface="action-sheet" label="Voice" placeholder="Select preferred voice">
            <ion-select-option v-for="v in voices" :key="v.lang" :value="v">{{ v.name }} ({{ v.lang }})</ion-select-option>
          </ion-select> -->
        </div>

        <!-- Voice -->
        <div class="form-group">
          <label>{{ $t("settings.voice.title") }} ({{ store.voice }})</label>
          <select v-model="store.voice" @change="store.setVoice($event.target?.value)">
            <option v-for="v in voices" :key="v.lang" :selected="v.lang == store.voice" :value="v.lang">{{ v.name }} ({{ v.lang }})</option>
          </select>
        </div>
        
        <!-- Rate -->
        <div class="form-group">
          <label>{{ $t("settings.rate.title") }} ({{ store.rate }})</label>
          <input v-model="store.rate" type="range" step="0.1" max="1.0" min="0.0" @change="store.setRate($event.target?.value)" />
        </div>

        <!-- Pitch -->
        <div class="form-group">
          <label>{{ $t("settings.pitch.title") }} ({{ store.pitch }})</label>
          <input v-model="store.pitch" type="range" step="0.1" max="1.0" min="0.0" @change="store.setPitch($event.target?.value)" />
        </div>

        <!-- Button columns -->
        <div class="form-group">
          <label>{{ $t("settings.buttonsColumns.title") }} ({{ store.buttonsColumns }})</label>
          <input v-model="store.buttonsColumns" type="number" step="1" max="10" min="1" @change="store.setButtonsColumns($event.target?.value)" />
        </div>

        <!-- Button rows -->
        <div class="form-group">
          <label>{{ $t("settings.buttonsRows.title") }} ({{ store.buttonsRows }})</label>
          <input v-model="store.buttonsRows" type="number" step="1" max="10" min="1" @change="store.setButtonsRows($event.target?.value)" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { TextToSpeech } from '@capacitor-community/text-to-speech';
import { ref, onMounted } from "vue";
import { useGeneralStore } from '@/store';
const store = useGeneralStore()

const voices = ref([] as SpeechSynthesisVoice[])

const getSupportedVoices = async () => {
  const response = await TextToSpeech.getSupportedVoices();
  voices.value = response.voices;
};

onMounted(async () => {
  getSupportedVoices();
})
</script>

<style lang="scss" scoped>
.settings-panel {
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;

  .settings-panel-overlay {
    z-index: 1;
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    background: rgba(0,0,0,0.3);
  }
  
  .settings-panel-inner {
    z-index: 2;
    position: absolute;
    top: 0;
    right: 0;
    height: 100%;
    width: 400px;
    background: white;
    border: 1px solid var(--border-color);
    box-shadow: 0 0 20px rgba(0,0,0,0.1);

   
  }
}

.settings {
  display: flex;
  gap: 1rem;
  flex-direction: column;
  padding: 2rem;
}

</style>
