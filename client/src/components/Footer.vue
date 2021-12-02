<template>
  <footer class="footer">
      <router-link to="/about" class="about-btn" custom v-slot="{ navigate }" id="button">       
            <button @click="navigate" @keypress.enter="navigate" role="link">Réglement</button>    
      </router-link>

      <button v-if="$store.state.isLoggedIn" @click="logOut" to="/" class="logout-btn">
         
            Déconnexion
      </button>

  </footer>
</template>

<script>
export default {
  name: "PageFooter",
  data: () => ({}),
  methods: {
    logOut: function() {
      this.$store.dispatch("logOut");
    },
  },
};
</script>
