
require('./bootstrap');

window.Vue = require('vue');

// COMPONENTES
Vue.component('example-component', require('./components/ExampleComponent.vue').default);
Vue.component('users-component', require('./components/Users.vue').default);
Vue.component('profile-component', require('./components/ProfileComponent.vue').default);
Vue.component('pers-inmuebles-component', require('./components/PersInmueblesComponent.vue').default);
Vue.component('gen-inmuebles-component', require('./components/GenInmueblesComponent.vue').default);

// LLAMADO A V-FORM
import { Form, HasError, AlertError } from 'vform';
window.Form = Form;
Vue.component(HasError.name, HasError)
Vue.component(AlertError.name, AlertError)

// LLAMADO A SWEET ALERTS
import Swal from 'sweetalert2';
window.Swal = Swal;

const Toast = Swal.mixin({
  toast: true,
  position: 'top-end',
  showConfirmButton: false,
  timer: 3000,
  timerProgressBar: true,
  onOpen: (toast) => {
    toast.addEventListener('mouseenter', Swal.stopTimer)
    toast.addEventListener('mouseleave', Swal.resumeTimer)
  }
})

window.Toast = Toast;

// LLAMADO A VUE-PROGRESSBAR
import VueProgressBar from 'vue-progressbar';

const options = {
  color: '#bffaf3',
  failedColor: '#874b4b',
  thickness: '4px',
  transition: {
    speed: '0.2s',
    opacity: '0.6s',
    termination: 300
  },
  autoRevert: true,
  inverse: false
}

Vue.use(VueProgressBar, options);

// DECLARACION FIRE PARA EVENTOS
let Fire = new Vue();
window.Fire = Fire;


const app = new Vue({
    el: '#app',
});
