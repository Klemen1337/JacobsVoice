<template>
  <div class="modal" v-if="store.editButton">
    <div class="modal-overlay" @click="cancel()"></div>
    <form class="modal-content" @submit.prevent="submit()">
      <div class="modal-header">
        <h1>{{ $t("modals.buttonEdit.header.title") }}</h1>
      </div>
      
      <div class="modal-body">
        <!-- ID -->
        <!-- <div class="form-group">
          <label>{{ $t("modals.buttonEdit.id.title") }}</label>
          <input v-model="button.id" type="text" />
        </div> -->

        <!-- Name -->
        <div class="form-group">
          <label>{{ $t("modals.buttonEdit.name.title") }}</label>
          <input v-model="button.name" type="text" />
        </div>

        <!-- <pre>{{ button }}</pre> -->
      </div>

      <div class="modal-footer">
        <button type="button" @click="cancel()">{{ $t("buttons.cancel.text") }}</button>
        <button type="submit">{{ $t("buttons.save.text") }}</button>
      </div>
    </form>
  </div>
</template>

<script setup lang="ts">
import { useGeneralStore } from '@/store';
import { ref, watch, Ref } from 'vue';
const store = useGeneralStore();
import { Button } from '@/models';


const button: Ref<Button> = ref({ id: "", name: "" })

watch(() => store.editButton, () => {
  button.value = JSON.parse(JSON.stringify(store.editButton))
})

function cancel () {
  store.setEditButton(null)
}

function submit () {
  store.updateButton(button.value)
  store.setEditButton(null)
}
</script>

<style lang="scss" scoped>

</style>
