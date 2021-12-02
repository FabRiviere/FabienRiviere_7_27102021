import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store/store';
import mdiVue from 'mdi-vue';
import * as mdijs from '@mdi/js'
import { ValidationProvider } from 'vee-validate';
import { sync } from 'vuex-router-sync'; 
// import VeeValidate from 'vee-validate';

Vue.config.productionTip = false;

 
const moment = require('moment') // gestion de l'affichage des dates avec vue-moment
require('moment/locale/fr')
Vue.use(require('vue-moment'), {
  moment
});

Vue.use(mdiVue, {
  icons: mdijs
}) 
Vue.component('ValidationProvider', ValidationProvider);

// Vue.use(VeeValidate);

const unsync = sync(store, router);

new Vue({
  router,
  store,
  render: (h) => h(App)
}).$mount('#app');

unsync();// Unsyncs store from router
