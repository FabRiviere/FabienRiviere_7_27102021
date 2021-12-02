<template>
  <div class="tooltip-box">
    <slot />
    <div
      class="tooltip"
    >
      <span
        class="text"
      >{{ text }}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: { 
    text: {
      type: String,
      required: true
    }
  }
};
</script>

<style scoped lang="css">
.tooltip-box { 
  /* width: 100%; */
  position: relative;
  /* display: flex;
  justify-content: flex-start; */
}

.tooltip-box:hover .tooltip{
  opacity: 1;
}

.tooltip { 
  color: #000000;
  text-align: center;
  padding: .3em 0;
  border-radius: .2em;
  
  width: 120px;
  bottom: 100%;
  right: 0;
  /* margin-left: -.5em; */

  opacity: 0;
  transition: opacity 1s;

  position: absolute;
  z-index: 1;

  background: #a782e8;
}

.text::after {
  content: " ";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #a782e8 transparent transparent transparent;
}
</style>