<template>
  <div class="home-container">
    <div class="form-container">
      <div class="form-container__title">Inscription</div>

      <form>
        <div class="input-form">
          <ValidationProvider
            name="pseudo"
            rules="required|minmax:3,30"
            v-slot="v"
            v-model="isValid"
            class="input-form"
          >
            <input
              v-model="pseudo"
              name="pseudo"
              type="text"
              class="input-form-field"
              placeholder="Pseudo"
              autocomplete="off"
            />
            <div class="error">{{ v.errors[0] }}</div>
          </ValidationProvider>
        </div>

        <div class="input-form">
          <ValidationProvider
            name="email"
            rules="required|email"
            v-slot="v"
            v-model="isValid"
            class="input-form"
          >
            <input
              v-model="email"
              name="email"
              type="email"
              class="input-form-field"
              autocomplete="off"
              placeholder="Adresse mail"
            />
            <div class="error">{{ v.errors[0] }}</div>
          </ValidationProvider>
        </div>

        <div class="input-form">
          <ValidationProvider
            name="password"
            rules="required|minmax:8,30"
            v-slot="v"
            v-model="isValid"
            class="input-form"
          >
            <input
              v-model="password"
              name="password"
              type="password"
              autocomplete="off"
              class="input-form-field form-control"
              placeholder="Mot de passe"
            />

            <div class="error">{{ v.errors[0] }}</div>
          </ValidationProvider>
        </div>
      </form>

      <div>
        <div class="danger-alert message" v-html="errorMessage"></div>
        <div class="danger-alert message" v-html="message"></div>
      </div>

      <button
        type="submit"
        class="button"
        :disabled="!isValid"
        v-on:click.prevent="signup"
      >
        Créer mon compte
      </button>
    </div>
  </div>
</template>

<script>
import Auth from "../services/Auth.js";
import { extend } from "vee-validate";
import { required, email } from "vee-validate/dist/rules";

// Override the default message.
extend("minmax", {
  validate(value, { min, max }) {
    return value.length >= min && value.length <= max;
  },
  params: ["min", "max"],
  message:
    "Le champs {_field_} doit avoir {min} caractères minimum et {max} caractères maximum ! ",
});
extend("email", email);

extend("required", {
  ...required,
  message: "Ce champ est obligatoire",
});

export default {
  name: "Signup",

  data() {
    return {
      pseudo: "",
      email: "",
      password: "",
      errorMessage: null,
      message: null,
      isValid: true,
      hasSignedUp: false,
    };
  },

  methods: {
    async signup() {
      try {
        const response = await Auth.signup({
          pseudo: this.pseudo,
          email: this.email,
          password: this.password,
        });
        this.message = response.data.message;
        this.$store.dispatch("setToken", response.data.token);
        this.$store.dispatch("setUser", response.data.user);
        this.$store.dispatch("getUserById", response.data.user.id);

        let router = this.$router;
        setTimeout(function () {
          router.push("/posts");
        }, 1500);
      } catch (error) {
        this.errorMessage = error.response.data.error;
        setTimeout(() => {
          this.errorMessage = "";
        }, 5000);
      }
    },
  },
};
</script>

