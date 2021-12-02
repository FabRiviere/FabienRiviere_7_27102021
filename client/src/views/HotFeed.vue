<template>
 <div class="feed-container">
      <div class="feed-container-bloc">
          <div>
              <div class="posts-card">
                  <img src="../assets/icon.png" alt="logo Groupomania" class="posts-card-img">
                  <h1>Le fil d'actualités</h1>
                  <div class="card-title">
                      <Tooltip text="Les plus récents" v-slot:activator="{ on, attrs }">
                          <button to="/posts" class="recents" v-bind="attrs" v-on="on">Les + récents</button>
                      </Tooltip>
                      <Tooltip text="Les plus likés" v-slot:activator="{ on, attrs }">
                          <button to="/hot" class="hot-posts" v-bind="attrs" v-on="on">Les + likés</button>
                      </Tooltip>
                      <Tooltip text="Publier" v-slot:activator="{ on, attrs }">
                          <button to="/add" class="add-btn" v-bind="attrs" v-on="on">
                          <mdicon name="pencil-outline" aria-label="publier" role="img"/>
                          </button>
                      </Tooltip>
                  </div>
              </div>
          </div>
      </div>
      <div class="feed-container-bloc2">
          <div>
              <div class="posts-card" v-if="$store.state.posts.length !== 0">
                  <div class="card-text">
                      <Posts v-for="post of posts" :key="post.id" :post="post" :id="post.id"
                        @deletePost="deletePost(post.id)" @likePost="likePost(post.id)" @reloadFeed="reloadFeed()"
                         @onSubmitComment="onSubmitComment(post.id)" @deleteComment="deleteComment(comment.id)">
                      </Posts>
                  </div>
              </div>
          </div>
      </div>
      <div class="posts-card" v-if="$store.state.posts.length === 0">
          <div class="card-title">
              <span>Sois le premier à publier un post ! </span>
          </div>
      </div>
  </div>
</template>

<script>
import Posts from "../components/Posts.vue";
// import { mdiPencilOutline } from "@mdi/js";
import Tooltip from '../components/Tooltip.vue';

export default {
  name: "HotFeed",
  components: {
    Posts,
    Tooltip,
  },
  data() {
    return {
      errorMessage: null,
    //   mdiPencilOutline,
    };
  },
  computed: {
    posts() {
      return this.$store.getters.posts;
    },
    isLiked() {
      return this.$store.getters.isLiked;
    },
  },
  async beforeMount() {
    this.$store.dispatch("getHotPosts");
  },
  methods: {
    deletePost(id) {
      this.$store.dispatch("deletePost", id);
    },
    deleteComment(id) {
      this.$store.dispatch("deleteComment", id);
    },

    likePost(id) {
      const data = 1;
      this.$store.dispatch("likePost", {
        id: id,
        data: data,
      });
    },
  },
};
</script>

<style></style>