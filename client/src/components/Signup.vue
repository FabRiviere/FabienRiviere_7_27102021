<template>

    <div class='home-container'>
       
    <div class='form-container'>
      <div class='form-container__title'>Inscription</div>
         
     
        <form> 
            <div class='input-form'>
          
          
                 <ValidationProvider name="pseudo" rules="required|between:3,30" v-slot="v" v-model="isValid"  class="input-form">
                <input 
                v-model="pseudo"
                name="pseudo"
                type="text"
                class="input-form-field"
                placeholder="Pseudo"
                autocomplete="off"
               />
                <div class="error">{{ v.errors[0] }} </div>
              </ValidationProvider>
     
            </div>

            <div class='input-form'>

              <ValidationProvider name="email" rules="required|email" v-slot="v" v-model="isValid" class="input-form">
              
                <input 
                  v-model="email"
                  name="email"
                  type="email"
                  class="input-form-field"
                  
                  autocomplete="off"
                  placeholder="Adresse mail"
                />
                <div class="error">{{ v.errors[0] }} </div>
             
              
              </ValidationProvider>
                
              
            </div>

            <div class='input-form'>
                <ValidationProvider name="password" rules="required" v-slot="v" v-model="isValid" class="input-form">
                <input 
                v-model="password"
                name="password"
                type="password"
                autocomplete="off"
                class="input-form-field form-control"
                placeholder="Mot de passe" />
                
                <div class="error">{{ v.errors[0] }} </div>
              </ValidationProvider>

            </div>
            
        </form>
      
        <div>
          <div class='danger-alert message' v-html="errorMessage"></div>
          <div class='danger-alert message' v-html="message"></div>
        </div>
        
            <button type="submit"  class="button" :disabled="!isValid"
            v-on:click.prevent="signup">
             Créer mon compte           
            </button>
        

    </div>
   
  </div>
  
</template>

<script>

import Auth from "../services/Auth.js";
// import { required, minLength, maxLength, alpha, email } from 'vuelidate/lib/validators';
import { extend } from 'vee-validate';
import { required, email, between  } from 'vee-validate/dist/rules';
// import { configure } from 'vee-validate';

extend('email', email);
extend('between', { 
  ...between,
  message: "le pseudo doit être composé entre 3 à 30 caractères" } )
// Override the default message.
extend('required', {
  ...required,
  message: 'Ce champ est obligatoire'
});
// configure({
//   classes: {
//     valid: 'is-valid',
//     invalid: 'is-invalid',
//     dirty: ['is-dirty', 'is-dirty'], // multiple classes per flag!
//     // ...
//   }
// })

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
      
      emailRules: [
        (v) => !!v || "L'email est obligatoire",
        (v) =>
          /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) ||
          "L'email doit être valide",
      ],
      pseudoRules: [
        (v) => v.length <= 30 || "Entre 3 et 30 caractères, sans symboles",
      ],
      passwordRules: [
        (v) =>
          v.length <= 30 ||
          "Le mot de passe doit être de 8 lettres minimum, majuscules et minuscules, pas de symboles",
      ],
    };    
  },
  // validations: {
  //   pseudo: {
      
  //     required,
  //     alpha
  //   },
  //   email: {
  //     required,
  //     email
  //   },
  //   password: {
  //     required,
  //     maxLength: maxLength(12),
  //     minLength: minLength(6)
  //   }
  // },
  methods: {
    // submitForm() {
    //   this.$v.touch();

    //   if(!this.$v.$invalid) {
    //     console.log(`Pseudo: ${this.pseudo}, Email: ${this.email}, Password: ${this.password} `)
    //   }
    // },
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

