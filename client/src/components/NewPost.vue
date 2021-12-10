<template>
  <div class="home-container">
    <div class="welcome__logo">
      <img src="../assets/icon.svg" alt="logo Groupomania" />
    </div>
    <div class="welcome new-post_title">
      <mdicon
        name="message-settings-outline"
        role="image"
        aria-label="message"
        size="48px"
      />
      <h1>Que partages tu aujourd'hui</h1>
    </div>
    <div class="post-card post-card-new">
      <form
        @submit.prevent="onSubmit"
        class="validate"
        enctype="multipart/form-data"
      >
        <ValidationProvider rules="required" v-slot="v" class="input-form">
          <input
            type="textarea"
            name="input-1-3"
            id="input-1-3"
            class="input-form-field"
            placeholder="Message"
            v-model="message"
          />
          <div class="error">{{ v.errors[0] }}</div>
        </ValidationProvider>
        <div class="card-text card-text-new" v-if="options">
          <div class="hospital-icon">
            <mdicon name="hospital-box" size="3em" />
          </div>
          <div class="post-content">
            <button class="button gif" @click="toggleLink">Gif</button>
            <button class="button gif" @click="toggleImage">Image</button>
          </div>
        </div>

        <div class="addImage">
          <div v-if="withImage" class="addImage">
            <div class="addImage-content">
              <label for="image" class="img-label">Image</label>
              <ValidationProvider
                rules="required|image"
                v-slot="v"
                class="input-form"
              >
                <input
                  @change="uploadImage"
                  type="file"
                  accept="image/png, image/jpeg,
                image/bmp, image/gif"
                  ref="file"
                  name=" charger une image"
                  class="input-form-field img-field"
                />
                <div class="error">{{ v.errors[0] }}</div>
              </ValidationProvider>
            </div>
          </div>
          <div v-if="withLink" class="addLink">
            <label for="gif" class="gif-label">Lien du gif</label>
            <input
              name="input-1-7"
              filled
              placeholder="Lien du gif"
              v-model="link"
              auto-grow
              class="input-form-field"
            />
          </div>
        </div>
        <div class="post">
          <button
            @click="onSubmit"
            :disabled="!isValid"
            class="button post-btn"
          >
            Poster
          </button>
        </div>
      </form>

      <br />
      <br />
      <div>
        <div class="danger-alert" v-html="errorMessage" />
        <div class="danger-alert" v-html="messageRetour" />
      </div>
    </div>
  </div>
</template>

<script>
import { extend } from "vee-validate";
import { required, image } from "vee-validate/dist/rules";
extend("image", image);
extend("required", {
  ...required,
  message: "Ce champ est obligatoire",
});
export default {
  name: "NewPost",

  data() {
    return {
      isValid: true,
      options: true,
      showLink: true,
      showImage: false,
      withLink: false,
      withImage: false,
      withText: false,
      message: "",
      link: null,
      file: "",
    };
  },
  computed: {
    messageRetour() {
      return this.$store.getters.message;
    },
    errorMessage() {
      return this.$store.getters.error;
    },
  },
  methods: {
    toggleLink() {
      (this.withLink = true), (this.options = false);
    },
    toggleImage() {
      (this.withImage = true), (this.options = false);
    },
    uploadImage() {
      const file = this.$refs.file.files[0];
      this.file = file;
    },
    onSubmit() {
      const formData = new FormData();
      formData.append("message", this.message);
      if (this.link !== null) {
        formData.append("link", this.link);
      }
      if (this.file !== null) {
        formData.append("image", this.file);
      }
      this.$store.dispatch("createPost", formData);
      this.$router.push("/posts");
    },
  },
};
</script>
<style lang="css" scoped>
</style>