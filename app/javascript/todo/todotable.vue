<template>
<div>
  <div style="margin-bottom:10px" v-for="card in  cards" class="to-do-card" @click="printCards">
    <div class="to-do-card-label" :style="{'background-color': card.card_color}">
    </div>
    <p style="position:overlay; margin-right: 20px">{{card.name}}</p>
  </div>
  
  
</div>


</template>

<script>
  import Swatches from 'vue-swatches'
  import "vue-swatches/dist/vue-swatches.min.css"

  export default {

    props: ["original_time_cards"],
    components: { Swatches },
    data: function() {
      return {
        color: '#194d33',
        cards: window.store.cards,
        editing: false,
        timer: null,
        totalTime: (0 * 0),
        resetButton: false,
        title: "Countdown to rest time!",
        edit: false
      }
    },
    methods: {
      getColor: function(event){
        console.log(event)
      },
        printCards: function(){
            console.log(this.cards)
        },
        updateValue: function(value){
          console.log(value.rgba)
        }
    }
      
  }


  </script>

  <style>


  </style>