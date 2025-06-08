<template>
  <ion-page>
    <ion-content :fullscreen="true" scroll-y="false">
      <div class="home-view" :class="{ 'in-edit-mode': store.isEditing }">
        <top-row></top-row>

        <div 
          class="grid" 
          :style="{ '--button-columns': store.buttonsColumns + '', '--button-rows': store.buttonsRows }"
        >
          <!-- Button -->
          <speak-button
            v-for="button in store.buttons" 
            :key="button.id" 
            :button="button"
          ></speak-button>

          <!-- Add button -->
          <button 
            v-if="store.isEditing"
            class="create-button"
            type="button" 
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
import { IonPage, IonContent } from "@ionic/vue";
import SettingsPanel from "@/components/SettingsPanel.vue";
import ButtonEdit from "@/components/ButtonEdit.vue";
import SpeakButton from "@/components/SpeakButton.vue";
import TopRow from "@/components/TopRow.vue";
import { useGeneralStore } from '@/store';
const store = useGeneralStore()
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

.in-edit-mode {
  .speak-button {
     &:nth-child(odd) {
      animation: 0.25s jiggle1 infinite;
      transform-origin: 50% 10%;
    }

    &:nth-child(even) {
      animation: 0.25s jiggle2;
      animation-iteration-count: infinite;
      animation-direction: alternate;
      transform-origin: 30% 5%;
    }

    &.hidden {
      opacity: 1;
      cursor: pointer;
    }
  }
}

@keyframes jiggle1 {
  0% {
    transform: rotate(-0.5deg);
    animation-timing-function: ease-in;
  }

  50% {
    transform: rotate(1deg);
    animation-timing-function: ease-out;
  }
}

@keyframes jiggle2 {
  0% {
    transform: rotate(0.5deg);
    animation-timing-function: ease-in;
  }

  50% {
    transform: rotate(-1.0deg);
    animation-timing-function: ease-out;
  }
}

.create-button {
  background: transparent;
  border-style: dashed;
  font-weight: normal;
  font-style: italic;
}

.grid {
  overflow: auto;
  --button-columns: 5;
  --button-rows: 4;
  flex-grow: 1;
  display: grid;
  gap: 1rem;
  grid-template-columns: repeat(var(--button-columns), minmax(0, 1fr));
  grid-template-rows: repeat(var(--button-rows), minmax(0, 1fr));
}
</style>