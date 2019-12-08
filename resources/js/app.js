require('./bootstrap');

window.Vue = require('vue');

Vue.component('profile-component', require('./components/ProfileComponent.vue').default);

const app = new Vue({
    el: '#app',
});
