import { createApp } from 'vue'
import App from './App.vue'
import router from './router';
import { IonicVue } from '@ionic/vue';
import { useGeneralStore } from './store';

/* Core CSS required for Ionic components to work properly */
import '@ionic/vue/css/core.css';

/* Basic CSS for apps built with Ionic */
import '@ionic/vue/css/normalize.css';
import '@ionic/vue/css/structure.css';
import '@ionic/vue/css/typography.css';

/* Optional CSS utils that can be commented out */
import '@ionic/vue/css/padding.css';
import '@ionic/vue/css/float-elements.css';
import '@ionic/vue/css/text-alignment.css';
import '@ionic/vue/css/text-transformation.css';
import '@ionic/vue/css/flex-utils.css';
import '@ionic/vue/css/display.css';

/* Theme variables */
import './theme/main.scss';

// Pinia
import { createPinia } from 'pinia'
const pinia = createPinia()

// i18n
import i18n from './i18n'

// App
const app = createApp(App);
app.use(IonicVue);
app.use(router);
app.use(pinia);
app.use(i18n);

router.isReady().then(async () => {
  const store = useGeneralStore()
  await store.init()

  app.mount('#app');
});
