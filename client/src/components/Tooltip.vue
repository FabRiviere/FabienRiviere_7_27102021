<template>
  <div class="tooltip-box">
    <slot />
    <div class="tooltip">
      <span class="text">{{ text }}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    text: {
      type: String,
      required: true,
    },
  },
};
</script>

<style scoped lang="css">
.tooltip-box {
  position: relative;
}

.tooltip-box:hover .tooltip {
  opacity: 1;
}

.tooltip {
  text-align: center;
  padding: 0.3em 0;
  border-radius: 0.5em;

  width: 120px;
  bottom: 100%;
  right: 0;
  opacity: 0;
  transition: opacity 1s;
  position: absolute;
  z-index: 1;
  background: #faf614;
  box-sizing: border-box;
  box-shadow: 0.3rem 0.3rem 0.6rem #c8d0e7, -0.2rem -0.2rem 0.5rem #fff;
  border: 0;
  outline: 0;
  font-weight: bold;
  color: #ae1100;
}

.text::after {
  content: " ";
  position: absolute;
  top: 100%;
  left: 75%;
  margin-left: -10px;
  border-width: 10px;
  border-style: solid;
  border-color: #ae1100 transparent transparent transparent;
}
</style>