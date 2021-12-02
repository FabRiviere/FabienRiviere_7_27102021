<template>
<div id="app">
<!-- header -->
    <page-header :user="user"></page-header>

  <main>
  <router-view></router-view>
  </main>

  <!-- Footer -->
   <page-footer :user="user"></page-footer>

  </div>
</template>

<script>
import PageHeader from "./components/Header.vue";
import PageFooter from "./components/Footer.vue";
import '../public/style.css';
export default {
  name: "app",
  components: {
    PageHeader,
    PageFooter
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

<style>
 @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;800&display=swap');

body {
  font-family: 'Poppins', sans-serif;
  margin:0;
  padding: 0;
  
}



</style>
