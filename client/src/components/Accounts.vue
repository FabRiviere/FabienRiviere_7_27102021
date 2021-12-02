<template>
  <div>
      <div class="home-container">
          <div class="accounts-box" v-if="$store.state.users">
                <div class="card-users" v-for="user of users" :key="user.id" :user="user">
                    <div class="card-container">
                        <div class="card-title">
                            <div class="avatar__accounts">
                                <img v-if="user.photo" :src="user.photo" alt="Photo de profil">
                                    <mdicon name="account-circle" role="avatar" 
                                    v-else-if="(user.photo === null) & ($store.state.user.id === user.id)" color="pink" size="96px"/>
                                    <mdicon name="account-circle" role="avatar" size="96px" v-else />
                            </div>
                            <div class="avatar-infos">
                                <div class="pseudo">
                                    
                                    <span><strong> {{ user.pseudo }} </strong></span>
                                </div>
                                <div class="mail_accounts button">
                                     
                                    <span><strong> {{ user.email }} </strong></span>
                                </div>
                            </div>
                        </div>

                        <Tooltip class="delete_accounts" text="Supprimer votre compte" v-if="($store.state.user.id === user.id) || ($store.state.user.admin === true) ">
                              <button type="button" @click="deleteAccount(user.id)" class="delete_comment">
                                  <mdicon name="trash-can" class="trash"/>
                              </button>
                             
                          </Tooltip>
                    </div>

                </div>
          </div>
      </div>
  </div>
</template>

<script>
import Tooltip from './Tooltip.vue';
export default {
name: "Account",
components: {
    Tooltip,
},

  data() {
    return {      
    };
  },
  computed: {
    users() {
      return this.$store.getters.users;
    }    
  },
  beforeMount() {
    this.$store.dispatch("getUsers");
  },
  methods: {
    getBackHome() {
      this.$router.push("/");
    },
    logOut() {
      this.$store.dispatch("setToken", null);
      this.$store.dispatch("setUser", null);
    },

    deleteAccount(id) {     
      if(this.$store.state.user.admin === true) {
        this.$store.dispatch("deleteAccount", id);
      }
      else {
        this.$store.dispatch("deleteAccount", id);
        this.$store.dispatch("logOut");
        this.getBackHome();
      }
    },
   
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="css">

</style>
