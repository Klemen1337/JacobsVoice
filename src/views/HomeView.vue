<template>
  <ion-page>
    <ion-content :fullscreen="true" scroll-y="false">
      <div class="home-view" :class="{ 'in-edit-mode': store.isEditing }">
        <div class="top-row">
          <!-- Input -->
          <input v-model="text" :placeholder="$t('input.speakText.placeholder')" />

          <!-- Edit -->
          <button type="button" :class="{ 'active': store.isEditing }" @click="store.toggleEditing()">
            <ion-icon :icon="createOutline"></ion-icon>
            <span v-if="!store.isEditing">{{ $t('buttons.edit.start-edit') }}</span>
            <span v-else>{{ $t('buttons.edit.stop-text') }}</span>
          </button>

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

        <div class="grid" :style="{ '--button-columns': store.buttonsColumns + '', '--button-rows': store.buttonsRows }">
          <button 
            class="btn"
            type="button"
            v-for="button in store.buttons" 
            :key="button.id" 
            @click="handleButtonClick(button)"
          >
            <span v-if="button.text">{{ button.text }}</span>
            <span v-else class="no-text">{{ $t('buttons.no-text') }}</span>
            <span v-if="store.isEditing" class="no-text">{{ $t('buttons.click-to-edit') }}</span>

            <!-- <div v-if="store.isEditing" class="button-actions">
              <button class="btn btn-sm" type="button">
                <ion-icon :icon="createOutline"></ion-icon>
                <span>{{ $t('buttons.actions.edit.text') }}</span>
              </button>
              <button class="btn btn-sm" type="button">Delete</button>
              <button class="btn btn-sm" type="button">Move</button>
            </div> -->
          </button>

          <button 
            class="create-button"
            type="button" 
            :class="{ 'hidden': !store.isEditing }"
            @click="store.addButton()"
          >
            {{ $t('buttons.new-button') }}
          </button>
        </div>
      </div>
    </ion-content>
    <button-edit></button-edit>
    <settings-panel></settings-panel>
  </ion-page>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue';
import { IonPage, IonContent, IonIcon } from '@ionic/vue';
import { playOutline, settingsOutline, createOutline } from 'ionicons/icons';
import SettingsPanel from "@/components/SettingsPanel.vue";
import ButtonEdit from "@/components/ButtonEdit.vue";
import { Button } from '@/models';
import { useGeneralStore } from '@/store';
const store = useGeneralStore()
const text = ref("")

onMounted (async () => {
  await store.init()
})

async function handleButtonClick(button: Button) {
  if (store.isEditing) {
    store.setEditButton(button)
    return;
  }

  text.value = button.text;
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
  // background-image: url("https://drscdn.500px.org/photo/51336416/q%3D90_m%3D2048/v2?sig=7f31569b5853520d3d62ec8f4a02b359fed58aba377882105802edd64c37ce90");
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

.in-edit-mode {
  button {
    &.hidden {
      opacity: 1;
      cursor: pointer;
    }
  }
}

.create-button {
  background: transparent;
  border-style: dashed;
  font-weight: normal;
  font-style: italic;
}

.btn {
  position: relative;
  flex-direction: column;

  .button-actions {
    position: absolute;
    top: 0;
    right: 0;
    padding: 1rem;
    display: flex;
    gap: 0.5rem;
  }
}

.grid {
  --button-columns: 5;
  --button-rows: 4;
  flex-grow: 1;
  display: grid;
  gap: 1rem;
  grid-template-columns: repeat(var(--button-columns), 1fr);
  grid-template-rows: repeat(var(--button-rows), 1fr);
}
</style>