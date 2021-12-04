<template>
  <div class="home-container">
      <div class="post-card">
          <div class="post-title-box">
              <div class="update-title">
                  <h1 class="titre_new">Modifier</h1>
                  <button class="button new_btn" @click="getBackToFeed">
                    <mdicon name="arrow-left-circle"/>
                    Retour
                  </button>
              </div>
          </div>
          <div class="card-text">
              <div class="cart-text-content" v-if="showMessage">
                  <div class="message-title">
                      <span class="mess-title">Ton message :</span>
                      <div class="message">
                          <span>{{ post.message }} </span>
                      </div>
                  </div>
              </div>
              <div class="text-box" v-if="withMessage">
                  <input type="text" name="input-7-4" id="input-7-4" v-model="message" required class="text-area input-form-field"/>
              </div>
              <div class="toggleMessage">
                  <button @click="toggleMessage" class="button">Modifier</button>
              </div>
          </div>
          <div class="validate" enctype="multipart/form-data">
              <div class="link-box" v-if="withLink">
                <input type="text" class="linkGif input-form-field" v-model="link" placeholder="lien du Gif" auto-grow filled>
              </div>
              <div class="image-box" v-if="showImage">
                  <img v-if="post.imageUrl" :src="post.imageUrl"/>
              </div>
              <div class="showLink" v-if="showLink">
                  <img v-if="post.link" :src="post.link"/>
              </div>
              <div class="withImage" v-if="withImage">
                  <label for="image">Image</label>
                  <input @change="uploadImage" type="file" aria-label="image input"
                    accept="image/png, image/jpeg,image/bmp, image/gif" ref="file" name="image"/>
              </div>
              <div class="card-text-options" v-if="options">
                  <div class="bloc-option">
                      <button v-if="post.link" @click="toggleLink" class="changeGif-btn button">Changer le Gif</button>
                      <button v-if="post.imageUrl" @click="toggleImage" class="changeImg-btn button">Changer l'image'</button>
                  </div>
              </div>
              <div class="modify-post-action">
                  <button type="submit" @click="onSubmit" :disabled="!isValid" class="button">Poster</button>
              </div>
          </div>
      </div>
  </div>
</template>

<script>
export default {
  name: "SinglePost",
  data() {
    return {
      options: true,
      isValid: true,
      withLink: false,
      withImage: false,
      withMessage: false,
      showLink: true,
      showImage: true,
      showMessage: true,
      message: "",
      link: "",
      file: "",
     
    };
  },
  computed: {
    post() {
      return this.$store.getters.post;
    },
   
  },
  beforeMount() {
    let id = this.$route.params.id;
    this.$store.dispatch("getPostById", id);
  },
  methods: {
    toggleMessage() {
      this.withMessage = true;
      this.showMessage = false;
    },
    toggleLink() {
      this.withLink = true;
      this.showLink = false;
    },
    toggleImage() {
      this.withImage = true;
      this.showImage = false;
    },
    uploadImage() {
      const file = this.$refs.file.files[0];
      this.file = file;
    },
    getBackToFeed() {
      this.$router.push("/posts");
    },
    onSubmit() {
      let id = this.$route.params.id;
      const formData = new FormData();
      if (this.message !== null) {
        formData.append("message", this.message);
      }

      if (this.link !== null) {
        formData.append("link", this.link);
      }
     
        formData.append("image", this.file);
      
      this.$store.dispatch("updatePost", formData);
      this.$store.dispatch("getPosts");
      this.$store.dispatch("getPostById", id);
      this.showImage = true;
      this.options = false;
      this.showLink = true;
      this.showMessage = true;
      this.withImage = false;
      this.withLink = false;
      this.withMessage = false;
      this.getBackToFeed();
    },

    newLink() {
      this.linkInput = true;
    },
    newText() {
      this.textInput = true;
    },
  },
};
</script>
<style lang="css" scoped>
.message {
  width: 500px;
  margin: 1.2em !important;
  padding: 15px;
}
</style>
