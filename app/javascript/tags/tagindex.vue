<template>

<div>
  <div class="to-do-card"  style="margin-left:15%;width:80%;background-color:rgba(0,0,0,0.1)" >
  </div>
  <div v-for="tag in tagList" >
    <div class="to-do-card" :style="{'background-color': tag.colour}" style="margin-left: 15%;width:80%" >
      <p style="font-size: x-large;margin-left: 10%;color: white;font-weight: bold;position: absolute;margin-top: 3%;">{{tag.name}}</p>
    </div>
  </div>
</div>

  
    
</template>


<script>
export default {
  props: ['tags'],
  data: function() {
    return {
      color: '#194d33',
      cardId: '',
      parentId: '',
      showDescription: true,
      showTimeSheet: false,
      editing: false,
      tagList: this.tags

    }
  }
}

</script>      