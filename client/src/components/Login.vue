<template>
    <div class='home-container'>
    <div class='form-container'>
      <div class='form-container__title'>Connexion</div>

        <form @submit.prevent="handleSubmit">
            
            <div class='input-form'>
                <label class='title' for='email'>
              <input id='email'
              v-model="email"
              name="email"
              type="email"
              v-validate="'required|email'"
              :class="{ 'is-invalid': submitted && errors.has('lastName') }"
              class="input-form-field form-control"
              autocomplete="off"
              placeholder="Adresse mail"/>
              </label>

              <div v-if="submitted && errors.has('email')" class="invalid-feedback">
                  {{ errors.first("email") }}
                </div>
            </div>

            <div class='input-form'>
                <label class='title' for='password'>
                <input id='password'
                v-model="password"
                name="password"
                type="password"
                v-validate="{ required: true, min: 6 }"
                :class="{ 'is-invalid': submitted && errors.has('password') }"
                class="input-form-field form-control"
                placeholder="Mot de passe" />
                </label>

                <div v-if="submitted && errors.has('password')" class="invalid-feedback">
                  {{ errors.first("password") }}
                </div>
            </div>
            
        </form>
        <div class='danger-alert message' v-html="errorMessage"></div>
        <div class='danger-alert message' v-html="message"></div>

        <div class="submit">
            <button :disabled="submitted"
            v-on:click.prevent="login" class="button">
            Me connecter
            </button>
        </div>

    </div>
  </div>
</template>

<script>
import Auth from "../services/Auth.js";
export default {
  name: "Login",
  data() {
    return {
      email: "",
      password: "",
      errorMessage: null,
      isValid: true,
      message: null,
      submitted: false,
    };
  },
  methods: {
    handleSubmit() {
      this.submitted = true;
      this.$validator.validate().then(valid => {
        if (valid) {
          alert("SUCCESS!! :-)\n\n" + JSON.stringify(this.user));
        }
      });
    },
    async login() {
      try {
        const response = await Auth.login({
          email: this.email,
          password: this.password,
        });
        this.message = response.data.message;
  
        this.$store.dispatch("setToken", response.data.token);
        this.$store.dispatch("setUser", response.data.user);
        this.$store.dispatch("getUserById", response.data.user.id);
        let router = this.$router;
        setTimeout(function() {
          router.push("/posts");
        }, 1500);
      } catch (error) {
        this.errorMessage = error.response.data.error;
        setTimeout(() => {
          this.email= "";
        this.password= "";
          this.errorMessage = "";
        }, 5000);
      }
    },
  },
};
</script>