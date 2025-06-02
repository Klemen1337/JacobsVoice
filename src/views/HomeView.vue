<template>
  <ion-page>
    <ion-content :fullscreen="true" scroll-y="false">
      <div class="home-view">
        <div class="top-row">
          <!-- Input -->
          <input v-model="text" placeholder="Type text or press a button..." />

          <!-- Settings -->
          <button type="button" @click="store.setSidebarOpen(true)">
            <ion-icon :icon="settingsOutline"></ion-icon>
            <span>{{ $t('buttons.settings') }}</span>
          </button>

          <!-- Play -->
          <button type="button" @click="speak()">
            <ion-icon :icon="playOutline"></ion-icon>
            <span>{{ $t('buttons.play') }}</span>
          </button>
        </div>

        <div class="grid">
          <button type="button" v-for="button in buttons" :key="button.id" @click="handleButtonClick(button)">{{ button.name }}</button>
        </div>
      </div>
    </ion-content>
    <settings-panel></settings-panel>
  </ion-page>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { playOutline, settingsOutline } from 'ionicons/icons';
import SettingsPanel from "@/components/SettingsPanel.vue";
import { useGeneralStore } from '@/store';
const store = useGeneralStore()
const text = ref("")
const buttons = ref(store.buttons)

onMounted (async () => {
  await store.init()
})

async function handleButtonClick(button: any) {
  text.value = button.name;
  return speak()
}

async function speak () {
  return await store.speak(text.value);
}
</script>


<style lang="scss" scoped>
.home-view {
  background: var(--bg-color);
  display: flex;
  flex-direction: column;
  gap: 1rem;
  padding: 1rem;
  padding-top: 2.5rem;
  height: 100vh;
  overflow: hidden;
  background-image: url("https://drscdn.500px.org/photo/51336416/q%3D90_m%3D2048/v2?sig=7f31569b5853520d3d62ec8f4a02b359fed58aba377882105802edd64c37ce90");
  background-position: center center;
  background-size: cover;
}

.top-row {
  display: flex;
  padding-bottom: 0;
  gap: 1rem;

  input {
    flex-grow: 1;
  }
}

.grid {
  flex-grow: 1;
  display: grid;
  gap: 1rem;
  grid-template-columns: repeat(5, 1fr);
  grid-template-rows: repeat(5, 1fr);
}
</style>