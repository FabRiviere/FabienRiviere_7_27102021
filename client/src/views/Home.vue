<template>
<v-container class="home-container">
    <span>
        <home-hero></home-hero>
    </span>
</v-container>
</template>

<script>
import HomeHero from '@/components/HomeHero';

export default {
    name: 'home',
    components: {
        HomeHero
    }
};
</script>

<style scoped>
.home-container {
    display: flex;
    justify-content: center;
    align-items: center;
}
</style>
