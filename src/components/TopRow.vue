<template>
  <div class="top-row">
    <!-- Input -->
    <input v-model="store.textToSpeak" :placeholder="$t('input.speakText.placeholder')" />

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
</template>

<script setup lang="ts">
import { playOutline, settingsOutline, createOutline } from 'ionicons/icons';
import { useGeneralStore } from '@/store';
const store = useGeneralStore()

async function speak () {
  return await store.speak(store.textToSpeak);
}
</script>

<style lang="scss" scoped>
.top-row {
  display: flex;
  padding-bottom: 0;
  gap: 1rem;
  flex-shrink: 0;

  input {
    flex-grow: 1;
  }
}

</style>
