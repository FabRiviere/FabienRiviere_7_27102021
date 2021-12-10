<template>
  <div class="feed-container">
    <div class="feed-container-bloc">
      <div class="posts-card">
        <div class="welcome__logo">
          <img src="../assets/icon.svg" alt="logo Groupomania" />
        </div>
        <div class="welcome">
          <h1>Les plus Likés !</h1>
        </div>
        <div class="feed-group-btn">
          <Tooltip text="Les plus récents">
            <router-link
              to="/posts"
              class="button recents"
              custom
              v-slot="{ navigate }"
              id="button"
            >
              <button
                @click="navigate"
                @keypress.enter="navigate"
                role="link"
                class="button"
              >
                Les + récents
              </button>
            </router-link>
          </Tooltip>
          <Tooltip text="Les plus likés">
            <router-link
              to="/hot"
              class="button hot-posts"
              custom
              v-slot="{ navigate }"
              id="button"
            >
              <button
                @click="navigate"
                @keypress.enter="navigate"
                role="link"
                class="button hot-posts"
              >
                Les + likés
              </button>
            </router-link>
          </Tooltip>
          <Tooltip text="Publier">
            <router-link
              to="/add"
              class="button add-btn"
              custom
              v-slot="{ navigate }"
              id="button"
            >
              <button
                @click="navigate"
                @keypress.enter="navigate"
                role="link"
                class="button add-btn"
              >
                <mdicon name="pencil-outline" aria-label="publier" role="img" />
              </button>
            </router-link>
          </Tooltip>
        </div>
      </div>
    </div>
    <div class="feed-container-bloc2">
      <div>
        <div class="posts-card" v-if="$store.state.posts.length !== 0">
          <div class="card-text">
            <Posts
              v-for="post of posts"
              :key="post.id"
              :post="post"
              :id="post.id"
              @deletePost="deletePost(post.id)"
              @likePost="likePost(post.id)"
              @reloadFeed="reloadFeed()"
              @onSubmitComment="onSubmitComment(post.id)"
              @deleteComment="deleteComment(comment.id)"
            >
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
import Tooltip from "../components/Tooltip.vue";

export default {
  name: "HotFeed",
  components: {
    Posts,
    Tooltip,
  },
  data() {
    return {
      errorMessage: null,
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