import Vue from 'vue';
import VueRouter from 'vue-router';
import Home from '../views/Home.vue';
import Signup from '../components/Signup.vue';
import Login from '../components/Login.vue';
import Feed from '../views/Feed.vue';
import HotFeed from '../views/HotFeed.vue';
import NewPost from '../components/NewPost.vue';
import Account from '../components/Account.vue';
import SinglePost from '../components/SinglePost.vue';
import Accounts from '../components/Accounts.vue';

Vue.use(VueRouter);

const routes = [
	{
		path: '/',
		name: 'Home',
		component: Home
	},
	{
		name: 'signup',
		path: '/signup',
		component: Signup
	},

	{
		name: 'login',
		path: '/login',
		component: Login
	},

	{
		name: 'account',
		path: '/account/:id',
		component: Account
	},
	{
		name: 'feed',
		path: '/posts',
		component: Feed
	},
	{
		name: 'hotFeed',
		path: '/hot',
		component: HotFeed
	},
	{
		name: 'singlePost',
		path: '/posts/:id',
		component: SinglePost
	},
	{
		name: 'accounts',
		path: '/accounts',
		component: Accounts
	},
	{
		name: 'NewPost',
		path: '/add',
		component: NewPost
	},

	{
		path: '/about',
		name: 'About',
		// route level code-splitting
		// this generates a separate chunk (about.[hash].js) for this route
		// which is lazy-loaded when the route is visited.
		component: () => import(/* webpackChunkName: "about" */ '../views/About.vue')
	}
];

const router = new VueRouter({
	mode: 'history',
	base: process.env.BASE_URL,
	routes
});

export default router;
