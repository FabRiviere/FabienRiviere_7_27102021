<template>

    <div class='home-container'>
       
    <div class='form-container'>
      <div class='form-container__title'>Inscription</div>
         
     
        <form> 
            <div class='input-form'>
          
          
                <label class='title' for='pseudo'></label>
                <input id="pseudo"
                v-model="pseudo"
                name="pseudo"
                type="text"
                class="input-form-field form-control"
                placeholder="Pseudo"
                :rules="[(v) => !!v || 'Pseudo is required']"
               />
                
          
                <!-- <span v-if="!$v.name.required && $v.name$dirty" class="invalid-feedback">Name is required !</span>
                 <span v-if="!$v.name.alpha && $v.name$dirty" class="invalid-feedback">Name is required !</span> -->

                
            </div>

            <div class='input-form'>
              <label class='title' for='email'></label>
              <input id='email'
              v-model="email"
              name="email"
              type="email"
              class="input-form-field form-control"
              autocomplete="off"
              placeholder="Adresse mail"
              :rules="emailRules"/>
              

              <!-- <span v-if="(!$v.email.required || $v.email.email ) && $v.email$dirty" class="invalid-feedback">Valid Email is required !</span> -->
                
              
            </div>

            <div class='input-form'>
                <label class='title' for='password'></label>
                <input id='password'
                v-model="password"
                name="password"
                type="password"
                :rules="[(v) => !!v || 'Password is required']"
                class="input-form-field form-control"
                placeholder="Mot de passe" />
                
               <!-- <span v-if="!$v.password.required && $v.password$dirty" class="invalid-feedback">Valid password is required !</span>
               <span v-if="(!$v.password.minLength || $v.password.maxLength) && $v.password$dirty" class="invalid-feedback">
                 Password must be between {{ $v.password.$params.minLength.min }} and {{ $v.password.$params.maxLength.max }} characters ! </span> -->

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