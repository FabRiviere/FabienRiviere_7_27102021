<template>
    <div class='home-container'>
    <div class='form-container'>
      <div class='form-container__title'>Connexion</div>

       
          <form >  
            <div class='input-form'>
              <ValidationProvider name="email" rules="required|email" v-slot="v" v-model="isValid" class="input-form">
                
                  <input 
                  v-model="email"
                  name="email"
                  type="email"
                  class="input-form-field"
                  autocomplete="off"
                  placeholder="Adresse mail"/>
                
                <div class="error">{{ v.errors[0] }} </div>
              </ValidationProvider>

            </div>

            <div class='input-form'>
              <ValidationProvider name="password" rules="required" v-slot="v" v-model="isValid" class="input-form">

                
                <input 
                  v-model="password"
                  name="password"
                  type="password"
                  class="input-form-field"
                  placeholder="Mot de passe"
                   autocomplete="off" />

                <div class="error">{{ v.errors[0] }} </div>
              </ValidationProvider>

            </div>
          </form>  
        
        <div class='danger-alert message' v-html="errorMessage"></div>
        <div class='danger-alert message' v-html="message"></div>

        <div class="submit">
            <button :disabled="!isValid"
            v-on:click.prevent="login" class="button">
            Me connecter
            </button>
        </div>

    </div>
  </div>
</template>

<script>
import Auth from "../services/Auth.js";
import { extend } from 'vee-validate';
import { required, email } from 'vee-validate/dist/rules';

extend('email', email);

// Override the default message.
extend('required', {
  ...required,
  message: 'Ce champ est obligatoire'
});
export default {
  name: "Login",
  data() {
    return {
      email: "",
      password: "",
      errorMessage: null,
      isValid: true,
      message: null,
      
    };
  },
  // computed: {
  //   isValid() {
  //     return this.email && this.password;
  //   }
  // },
  
  methods: {
    // handleSubmit() {
    //   this.submitted = true;
    //   this.$validator.validate().then(valid => {
    //     if (valid) {
    //       alert("SUCCESS!! :-)\n\n" + JSON.stringify(this.user));
    //     }
    //   });
    // },
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