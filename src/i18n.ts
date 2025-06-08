import { createI18n } from 'vue-i18n'

// Import locale messages
import en from '../resources/locales/en.json'
import sl from '../resources/locales/sl.json'

const messages = {
  en,
  sl,
}

const i18n = createI18n({
  legacy: false, // Use Composition API
  locale: 'sl', // Set default locale
  fallbackLocale: 'en', // Fallback when a translation is missing
  messages,
  globalInjection: true, // Allows using $t in templates without needing to import useI18n,
  missingWarn: false, 
  fallbackWarn: false,
  silentTranslationWarn: true,
})

export default i18n