<template>
  <div class="account-container">
    <div class="account-box" v-if="$store.state.isLoggedIn">
      <div class="account-box-container">
        <div class="account-card">
          <div class="profil-top">
            <router-link to="/posts" class="back button">
              <mdicon name="arrow-left-circle" />
              Retour
            </router-link>
            <div class="card-title">
              <h1 class="titre">Modifier votre profil</h1>

              <div class="delete_account">
                <Tooltip
                  text="Supprimer votre compte"
                  v-if="!$store.state.user.admin === true"
                >
                  <button
                    type="button"
                    @click="deleteAccount(user.id)"
                    class="delete_comment"
                  >
                    <mdicon name="trash-can" class="trash" />
                  </button>
                </Tooltip>
              </div>
            </div>
          </div>

          <div class="profil-middle">
            <div class="profil-middle__left" v-if="showPseudo">
              <span class="pseudo">Bonjour {{ user.pseudo }} !</span>
              <button class="button" @click="togglePseudo">
                Modifier le pseudo
              </button>
            </div>

            <ValidationProvider
              name="pseudo"
              rules="required|minmax:3,30"
              v-slot="v"
              v-model="isValid"
              class="input-form"
            >
              <input
                type="text"
                name="newPseudo"
                id="newPseudo"
                v-if="updatePseudo"
                v-model="newPseudo"
                placeholder="Nouveau Pseudo"
                counter="30"
                class="input-form-field"
              />
              <div class="error">{{ v.errors[0] }}</div>
            </ValidationProvider>

            <div class="profil-middle__right">
              <div class="avatar__account" v-if="showPhoto">
                <img
                  v-if="user.photo"
                  :src="user.photo"
                  alt="Photo de profil"
                  class="avatar__account"
                />
                <mdicon
                  :color="isLoggedIn"
                  size="96px"
                  aria-label="avatar"
                  v-else
                  class="mdi-account-circle"
                  name="account-circle"
                />
              </div>

              <button @click="togglePhoto" class="button">
                Changer la photo
              </button>
            </div>

            <div class="account_Photo" v-if="updatePhoto">
              <ValidationProvider rules="image" v-slot="v" class="input-form">
                <input
                  type="file"
                  @change="uploadImage"
                  accept="image/*"
                  ref="file"
                  name="image"
                  id="image"
                  class="updatePhoto"
                />
                <div class="error">{{ v.errors[0] }}</div>
              </ValidationProvider>
            </div>
          </div>

          <div class="bio" v-if="showBio">
            <div class="bio-container">
              <strong>Ta Bio: </strong>
              <div class="bio-text">
                <span v-if="!user.bio"> Dis nous en + sur toi </span>
                <span v-else>{{ user.bio }} </span>
              </div>
            </div>
            <button @click="toggleBio" class="button bio-btn">Modifier</button>
          </div>
          <div>
            <ValidationProvider
              name="bio"
              rules="required|minmax:2,400"
              v-slot="v"
              v-model="isValid"
              class="input-form"
            >
              <input
                type="textarea"
                class="input-form-field field-bio"
                v-model="newBio"
                v-if="updateBio"
                aria-label="Bio"
                placeholder=" nouvelle Bio"
              />
              <div class="error">{{ v.errors[0] }}</div>
            </ValidationProvider>
          </div>
          <div class="card-text" v-if="options">
            <br />
            <div class="danger-alert" v-html="errorMessage"></div>
            <div class="danger-alert" v-html="messageRetour"></div>
            <div class="submit">
              <button
                type="submit"
                @click="onSubmit(user.id)"
                :disabled="!isValid"
                class="button"
              >
                Envoyer
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="card" v-else>
      <div class="card-title post-title-box">
        <div class="update-title">
          <span class="title">Votre compte a été supprimé</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Tooltip from "./Tooltip.vue";
import { extend } from "vee-validate";
import { required } from "vee-validate/dist/rules";

// Override the default message Vee-validate.
extend("minmax", {
  validate(value, { min, max }) {
    return value.length >= min && value.length <= max;
  },
  params: ["min", "max"],
  message:
    "Le champ {_field_} doit avoir {min} caractères minimum et {max} caractères maximum ! ",
});
extend("required", {
  ...required,
  message: "Ce champ est obligatoire",
});

export default {
  name: "Account",
  components: {
    Tooltip,
  },

  data() {
    return {
      updateBio: false,
      updatePseudo: false,
      updatePhoto: false,
      showPseudo: true,
      showPhoto: true,
      showBio: true,
      isValid: true,
      options: false,
      newPseudo: "",
      newBio: "",
      file: "",
      messageRetour: null,
      errorMessage: null,
    };
  },

  computed: {
    user() {
      return this.$store.getters.user;
    },
    isLoggedIn() {
      if (this.$store.state.isLoggedIn) {
        return "pink";
      } else {
        return "";
      }
    },
  },
  beforeMount() {
    this.$store.dispatch("getUserById");
  },
  methods: {
    getBackHome() {
      this.$router.push("/");
    },
    togglePseudo() {
      this.updatePseudo = true;
      this.showPseudo = false;
      this.options = true;
    },
    togglePhoto() {
      this.updatePhoto = true;
      this.showImage = false;
      this.options = true;
      this.showPhoto = false;
    },
    toggleBio() {
      this.updateBio = true;
      this.showBio = false;
      this.options = true;
    },
    uploadImage() {
      const file = this.$refs.file.files[0];
      this.file = file;
      console.log(this.file);
    },
    onSubmit() {
      const formData = new FormData();
      formData.append("pseudo", this.newPseudo);
      formData.append("bio", this.newBio);
      if (this.file !== null) {
        formData.append("image", this.file);
      }
      this.$store.dispatch("getUsers");
      this.$store.dispatch("getUserById", this.user.id);
      this.$store.dispatch("updateAccount", formData);
      this.$store.dispatch("getUserById", this.user.id);

      this.updateBio = false;
      this.updatePhoto = false;
      this.updatePseudo = false;
      this.options = false;
      this.showBio = true;
      this.showPhoto = true;
      this.showPseudo = true;
    },
    deleteAccount(id) {
      this.$store.dispatch("deleteAccount", id);
      this.$store.dispatch("logOut");
      setTimeout(() => {
        this.getBackHome();
      }, 2000);
    },
  },
};
</script>

