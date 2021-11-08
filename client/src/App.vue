<template>
    <v-app>
        <app-navigation :user='user'></app-navigation>

        <v-main>
            <router-view></router-view>
        </v-main>

        <app-footer :user='user'></app-footer>
    </v-app>
</template>

<script>
import AppNavigation from '@/components/AppNavigation.vue';
import AppFooter from '@/components/Footer.vue';
import '../public/style.css';

export default {
    name: 'App',
    components: {
        AppNavigation,
        AppFooter
    },
    data: () => {
    return {      
    };
  },
   computed:{
     user() {
       return this.$store.getters.user
     }
   },
   mounted() {
     if(this.user.email) {
     this.$store.dispatch("getUsers");
     this.$store.dispatch("getUserById", this.user.id);

     }
   }
};
</script>
