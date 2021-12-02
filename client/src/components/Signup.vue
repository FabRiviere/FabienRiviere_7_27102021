<template>
    <div class='home-container'>
    <div class='form-container'>
      <div class='form-container__title'>Inscription</div>

        <form @submit.prevent="handleSubmit">
            <div class='input-form'>
          
                <label class='title' for='pseudo'>
                <input id="pseudo"
                v-model="pseudo"
                name="pseudo"
                type="text"
                v-validate="'required'"
                :class="{ 'is-invalid': submitted && errors.has('pseudo') }"
                class="input-form-field form-control"
                placeholder="Pseudo"/>
                </label>

                <div v-if="submitted && errors.has('firstName')" class="invalid-feedback">
                  {{ errors.first("pseudo") }}
                </div>

                             
            </div>

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
        <div>
          <div class='danger-alert message' v-html="errorMessage"></div>
          <div class='danger-alert message' v-html="message"></div>
        </div>
        
            <button  class="button" :disabled="submitted" 
            v-on:click.prevent="signup">
             Créer mon compte           
            </button>
        

    </div>
  </div>
</template>

<script>

import Auth from "../services/Auth.js";


export default {
  name: "Signup",
  components: {
    
  },
  
  data() {
    return {
      pseudo: "",
      email: "",
      password: "",
      errorMessage: null,
      message: null,
      isValid: true,
      hasSignedUp: false,
      submitted: false,

      // emailRules: [
      //   (v) => !!v || "L'email est obligatoire",
      //   (v) =>
      //     /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) ||
      //     "L'email doit être valide",
      // ],
      // pseudoRules: [
      //   (v) => v.length <= 30 || "Entre 3 et 30 caractères, sans symboles",
      // ],
      // passwordRules: [
      //   (v) =>
      //     v.length <= 30 ||
      //     "Le mot de passe doit être de 8 lettres minimum, majuscules et minuscules, pas de symboles",
      // ],
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
        setTimeout(function() {
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