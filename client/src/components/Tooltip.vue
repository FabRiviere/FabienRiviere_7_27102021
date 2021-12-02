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
  /* color: #000000; */
  text-align: center;
  padding: .3em 0;
  border-radius: .5em;
  
  width: 120px;
  bottom: 100%;
  right: 0;
  /* margin-left: -.5em; */

  opacity: 0;
  transition: opacity 1s;

  position: absolute;
  z-index: 1;

  background: #faf614;

  box-sizing: border-box;
  box-shadow: .3rem .3rem .6rem #c8d0e7, 
  -.2rem -.2rem .5rem #FFF;
  border: 0;
  outline: 0;
  /* border-radius: 1em ; */
  font-weight: bold;
  color: #AE1100;
}

.text::after {
  content: " ";
  position: absolute;
  top: 100%;
  left: 75%;
  margin-left: -10px;
  border-width: 10px;
  border-style: solid;
  border-color: #AE1100 transparent transparent transparent;
}
</style>