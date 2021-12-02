<template>
  <div class="post-box">
      <div class="post-card">
          <div class="post-title-box">
              <div class="update-title">
                  <h1 class="titre_new">Modifier</h1>
                  <button class="return-btn" @click="getBackToFeed">Retour</button>
              </div>
          </div>
          <div class="card-text">
              <div class="cart-text-content" v-if="showMessage">
                  <div class="message-title">
                      <span>Ton message: </span>
                      <div class="message">
                          <span>{{ post.message }} </span>
                      </div>
                  </div>
              </div>
              <div class="text-box" v-if="withMessage">
                  <input type="text" name="input-7-4" id="input-7-4" v-model="message" required class="text-area"/>
              </div>
              <div class="toggleMessage">
                  <button @click="toggleMessage">Modifier</button>
              </div>
          </div>
          <form action="" class="validate" enctype="multipart/form-data" method="post">
              <div class="link-box" v-if="withLink">
                <input type="text" class="linkGif" v-model="link" placeholder="lien du Gif">
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
                      <button v-if="post.link" @click="toggleLink" class="changeGif-btn">Changer le Gif</button>
                      <button v-if="post.imageUrl" @click="toggleImage" class="changeImg-btn">Changer l'image'</button>
                  </div>
              </div>
              <div class="post-action">
                  <button type="submit" @click="onSubmit" :class="{'button--disabled' : !isValid}">Poster</button>
              </div>
          </form>
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
      link: null,
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
          this.$store.dispatch("getPosts");
      this.$store.dispatch("updatePost", formData);
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

.return-btn {
  position: absolute;
  right: 0;
  top: 10px;
}
.link-box {
  display: flex;
  align-content: center;
}
.message {
  width: 500px;
  margin: 1.2em !important;
  padding: 15px;
}
</style>
