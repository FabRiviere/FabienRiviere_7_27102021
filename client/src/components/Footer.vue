<template>
  <footer class="footer">
    <router-link to="/about" class="black-btn" id="button">
      Réglement
    </router-link>

    <router-link to="/" class="router-btn">
      <button v-if="$store.state.isLoggedIn" @click="logOut" class="black-btn">
        Déconnexion
      </button>
    </router-link>
  </footer>
</template>

<script>
export default {
  name: "PageFooter",
  data: () => ({}),
  methods: {
    logOut: function () {
      this.$store.dispatch("logOut");
    },
  },
};
</script>
