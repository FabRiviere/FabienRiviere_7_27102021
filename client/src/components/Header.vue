<template>
  <header class="header">
      <nav class="nav">
          <router-link to="/">
            <img class="nav_logo" src="../assets/icon-left-white.png" alt="Logo Groupomania"/>
         </router-link>

         <div class="btngroup">
             <router-link to="/posts" class="black-btn"  id="button" v-if="isLogged === true" aria-label="fil d'actualité">
               <!-- custom v-slot="{ navigate }"<button @click="navigate" @keypress.enter="navigate" role="link" class="news"> -->
                Fil d'actualité <!-- </button>   -->
             </router-link>

             <router-link to="/login" class="black-btn" id="button" v-if="isLogged === false" aria-label="Connexion">
                <!-- <button @click="navigate" @keypress.enter="navigate" role="link" class="connect">Connexion</button> -->
             Connexion
             </router-link>

             <router-link to="/signup" class="black-btn" id="button" v-if="isLogged === false" aria-label="Inscription">
               <!-- <button @click="navigate" @keypress.enter="navigate" role="link">S'inscrire</button>  -->
             S'inscrire
             </router-link>

             <router-link :to="`/account/${user.id}`" v-if="isLogged === true" class="black-btn profil" aria-label="profil">
              
                <img :src="user.photo" alt="Avatar" class="avatar__img" v-if="user.photo"/>
                <mdicon class="avatar__icon" name="account-circle" v-if="user.photo === null"  size="52px"/>
             
             </router-link>

             <router-link to="/accounts" class=" black-btn profil" id="button" v-if="isLogged === true" aria-label="tous les profils">
                <!-- <span @click="navigate" @keypress.enter="navigate" role="link" > -->
                <mdicon class="mdi-account-circle " name="account-group" size="52px" />
                 <!-- </span>              -->
             </router-link>

         </div>
       
      </nav>
  </header>
</template>

<script>

export default {
  name: "PageHeader",
  props: {
    user: {
      type: Object,
    },
  },
  data() {
    return {};
    
  },
  computed: {
    isLogged() {
      return this.$store.getters.isLogged
    },
    isLoggedIn() {
      if (this.$store.state.isLoggedIn) {
        return "";
      } else {
        return "";
      }
    },
   
  },
  methods: {    
    getProfile(id) {
      this.$router.push(`/account/${id}`);
    },
    
    
  },
};
</script>

<style scoped>

</style>