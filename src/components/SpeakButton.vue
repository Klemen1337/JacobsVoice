<template>
  <button 
    class="btn speak-button"
    type="button"
    :style="{ '--button-bg': button.backgroundColor, '--button-color': button.color }"
    @click="handleButtonClick()"
  >
    <img class="speak-button-image" v-if="button.image" :src="button.image" />
    <span class="speak-button-text" v-if="button.text">{{ button.text }}</span>
    <span v-else class="speak-button-text no-text">{{ $t('buttons.no-text') }}</span>
    <span v-if="store.isEditing" class="speak-button-text no-text">{{ $t('buttons.click-to-edit') }}</span>
  </button>
</template>

<script setup lang="ts">
import { useGeneralStore } from '@/store';
import { defineProps, PropType } from 'vue';
import { Button } from '@/models';
const store = useGeneralStore();

const props = defineProps({
  button: {
    type: Object as PropType<Button>,
    required: true
  }
})

async function handleButtonClick() {
  if (store.isEditing) {
    store.setEditButton(props.button)
    return;
  }

  store.textToSpeak = props.button.text
  return store.speak(store.textToSpeak)
}
</script>

<style lang="scss" scoped>
.speak-button {
  position: relative;
  flex-direction: column;

  img {
    flex-grow: 1;
    max-height: 80px;
    border-radius: var(--border-radius);
  }

  .speak-button-text {
    flex-shrink: 0;
  }
}
</style>
