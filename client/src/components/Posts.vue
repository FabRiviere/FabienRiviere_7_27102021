<template>
  <div class="container-posts">
      <div class="post-card-container">
          <div class="post-card-only">
              <div class="post-card-contain">
                  <div class="post-title">
                      <div class="profil-post">
                          <img v-if="post.User.photo" :src="post.User.photo" alt="photo de profil" class="avatar__post"/>
                          <mdicon name="account-circle"  
                          v-else-if="post.User.photo === null && post.User.id === $store.state.user.id" size="96px"/>
                          <mdicon name="account-circle" role="avatar" v-else class="avatar__post" size="96px" />
                      </div>
                      <div class="nom-date">
                          <span class="pseudo">{{ post.User.pseudo }} </span>
                          <span class="date">{{ post.createdAt | moment("calendar") }} </span>
                      </div>
                  </div>
                  <div class="post-options">

                    <Tooltip text="Modifier le post" v-if="$store.state.user.id == post.User.id" class="updatePost">
                        <button type="button" @click="getOnePost(post.id)" class="updatePost-btn">
                            <mdicon name="pencil-circle" class="update" />
                        </button>
                        
                    </Tooltip>

                    <Tooltip text="Supprimer le post" v-if="$store.state.user.id == post.User.id || $store.state.user.admin === true" class="deletePost">
                        <button type="button" @click="deletePost(post.id)" class="deletePost-btn">
                            <mdicon name="trash-can" class="trash"/>
                        </button>
                        
                    </Tooltip>

                  </div>
              </div>
              
              <div class="card-text-body">
                  <div class="card-text-left">
                      <p class="body-1">{{ post.message }} </p>
                  </div>
              </div>
              <div class="postImgLink">
                  <img v-if="post.link" :src="post.link" alt="lien posté par l'utilisateur" class="post-link"/>
                  <img v-if="post.imageUrl" :src="post.imageUrl" alt="image postée par l'utilisateur" class="post-img"/>
              </div>
              <div class="commentsLikes">
                  <div class="comments-posts">{{ post.Comments.length }} Comments</div>
                  <div class="likes-posts">{{ post.Likes.length }} J'aime</div>
              </div>
              <div class="card-actions">
                  <div class="card-actions-comments button">
                    <button @click="show = !show" aria-label="accès commentaires">Commentaires</button>
                    <button type="icon" @click="show = !show" aria-label="accès commentaires">
                      <mdicon name="chevron-up" v-if="show = show"/>
                      <mdicon name="chevron-down" v-else/>
                    </button>
                  </div>
                  <div class="card-actions-likes">
                      <button class="like-btn" @click="likePost(post.id)" aria-label="liker">
                      <mdicon name="heart-plus" :color="isLiked"/>
                      </button>
                  </div>
                  
              </div>
              <div class="expand-transition">
                  <div v-show="show">
                      <div class="comments-box">
                          <div class="card-comment-input">
                              <form @submit.prevent="onSubmitComment(post.id)">
                                  <input type="text" name="input-1-4" id="input-1-4" placeholder="ton commentaire" 
                                  v-model="data.commentMessage" class="input-form-field" required/>

                                  <button type="submit" :disabled="!isValid"  @click="onSubmitComment(post.id)"
                                  class="button comment-btn">Poster</button>
                              </form>

                              <div>
                                <div class="danger-alert" v-html="errorMessage" />
                                <div class="danger-alert" v-html="messageRetour" />
                              </div>
                          </div>

                          <div class="list" v-for="comment in post.Comments" :key="comment.id" :comment="comment">
                              <div class="list-item-comment">
                                  <div class="comment_photo">
                                      <img v-if="comment.User.photo !== null" :src="comment.User.photo" alt="Photo de profil"/>
                                      <mdicon name="account-circle" v-else-if="comment.User.photo === null && comment.UserId === $store.state.user.id"
                                      role="avatar" size="64px" />
                                      <mdicon name="account-circle" role="avatar" v-else />
                                  </div>
                                  <div class="comment_body">
                                      <strong v-html="comment.User.pseudo" class="comment__pseudo"></strong>
                                      <span class="comment__message" v-html="comment.message"></span>
                                  </div>

                                  <Tooltip text="Supprimer commentaire" v-if="$store.state.user.id === comment.UserId 
                                      || $store.state.user.admin === true" class="delete">
                                  <div class="delete">
                                   <button @click="deleteComment(comment.id)" class="delete_comment">
                                    <mdicon name="trash-can" aria-label="supprimer commentaire" class="trash"/>
                                   </button>
                                  </div>
                                  </Tooltip>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
      </div>
  </div>
</template>

<script>
import Tooltip  from './Tooltip.vue';
import PostService from "../services/PostService";


export default {
  name: "Posts",
  components: {
      Tooltip,
  },

  props: {
    post: {
      type: Object,
    },
  },
  data: function() {
    return {
      show: false,
      width: 500,
      commentForm: false,
      user: false,
      showFeed: true,
      update: false,
      isValid: true,
      rules: {
        required: (value) => !!value || "Required.",
      },
      messageRetour: null,
      errorMessage: null,
      data: {
        commentMessage: "",
        commentPseudo: this.$store.state.user.pseudo,
        
      },
    };
  },
  computed: {
    isLiked() {
      const userId = this.$store.state.user.id;
      let userLike = this.post.Likes.map((a) => a.UserId);
      if (userLike.includes(userId)) {
        return "pink";
      } else {
        return "";
      }
    },
  },

  methods: {
    async reloadFeed() {
      try {
        const response = await PostService.getPosts();
        this.posts = response.data;
      } catch (error) {
        this.errorMessage = error.response.data.error;
      }
    },
    getProfile(id) {
      this.$router.push(`/account/${id}`);
    },
    deletePost() {
      this.$emit("deletePost", this.post.id);
    },
    likePost() {
      this.$emit("likePost", this.post.id);
    },
    getOnePost(id) {
      this.$router.push(`posts/${id}`);
    },
    onSubmitComment(id) {
      this.$store.dispatch("getPosts");
      this.$store.dispatch("commentPost", {
        id: id,
        data: this.data,
      });
      this.data.commentMessage = "";
      this.$store.dispatch("getPosts");
      this.$store.dispatch("getPostById", this.post.id);
    },

    deleteComment(id) {
      
      this.$store.dispatch("deleteComment", id);
     
        this.reloadFeed();
      
      
    },
  },
};
</script>

