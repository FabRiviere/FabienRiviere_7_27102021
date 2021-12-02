<template>
  <div class="home-container">
    <div class="bandeau">
      <div class="welcome__logo">
        <img src="../assets/icon.svg" alt="logo Groupomania">
      </div>
      <div class="welcome">
        <h1>GroupoMania Social</h1>
        <h2>Bienvenue sur votre nouveau reseau social</h2>
      </div>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src


export default {
  name: 'Home',
  methods: {
    logOut: function() {
      this.$store.dispatch("logOut");
    },
  },
}
</script>
