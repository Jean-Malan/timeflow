<template>

  <div class='col-md-3 align-top card card-body fix' style="box-shadow: none;background-color: rgba(0,0,0,0);min-height: 1000px; min-width: 500px" :data-index="list.id">
    <div class="inline row" style="margin-top: -1%;">
      <strong> <p style="margin-top:-100%color:grey;font-size:18px">{{list.name}}</p></strong>
      <div v-if="list.cards.length <= 0"> <i style="margin-left: 350px;" class="fa fa-trash pull-right" v-if="!editing" @click="deleteList"></i></div>
    </div>  
    <hr />

    <draggable  :options="{group: 'cards'}" class='dragArea' @end="cardMoved" style="margin-left: 20px !important;max-height: 65%;">
      <card v-for="(card, index) in card_list" v-if="card.listing_id == listing_id" :card="card" :data-id="card.id" :card_list="card_list" > </card>   
    </draggable>
    <div class="element1">
      <i class="fa fa-plus" v-if="!editing" @click="startEditing"></i>
    </div>
    <div v-if="editing" class="card card-body card-dark" style="margin-top: 10%;max-height: 200px;">
      <textarea :listId="list.id" v-model="message" ref="message" class="form-control" style="line-height: 81px;"></textarea>
      <span>
        <button @click="submitMessages" class="btn btn-primary" :data-index="list.id">Add Card</button>
        <a @click="editing=false">Cancel</a>
      </span>  
    </div>
  </div>



</template>

<script>

import draggable from 'vuedraggable'
import card from 'components/card'

export default {
  components: { draggable, card },
    name: 'lists',
    props: ["list", "clientId", "cards", "listId"],
    data: function() {
       return {
        card_list: this.cards,
        client: this.clientId,
        editing: false,
        message: "",
        listing_id: this.listId,
      }
    },
    methods: {
      submitMessages: function(event) {
        // console.log(this.client)
        var data  = new FormData;
        // console.log(window.store.client)
        console.log(event.target.dataset.index)
        this.listing_id = event.target.dataset.index 

        data.append("card[listing_id]", this.listing_id);
        data.append("card[name]",this.message);
        data.append("card[tag_id]", 1);
        data.append("card[client_id]", this.clientId)

        Rails.ajax({
          url: "/cards",
          type: "POST",
          data: data,
          dataType: "json",
          success: (data) => {
            // const index = window.store.lists.findIndex((item) => item.id == this.listing_id);
            console.log(data)

            window.store.cards.push()

            var clientIndex =  window.store.clients.findIndex((i) => i.id == this.clientId)
            var cardIndex = window.store.cards.length - 1
            window.store.cards[cardIndex].client = window.store.clients[clientIndex]
            window.store.cards[cardIndex].tag = window.store.tags[0]
            window.store.cards[cardIndex].name = this.message
            window.store.cards[cardIndex].listing_id = this.listing_id
            this.message = ""
          }
        })
      },

      deleteList: function() {
       Rails.ajax({
            url: '/listings/' + this.list.id,
            type: "Delete",
            dataType: "json",
            success: () => {
              var list_index = window.store.lists.findIndex((item) => item.id == this.list.id)
              window.store.lists.splice(list_index, 1)
            }
          })
      },

        cardMoved: function(event){
          console.log("hi")
          console.log(event)
          var new_column = (event.to.offsetParent.dataset.index)
          var card_id =  (event.clone.dataset.id)
          var new_position =  (event.newIndex + 1)

          var data  = new FormData;
          data.append("card[listing_id]", new_column );
          data.append("card[position]", new_position );

          Rails.ajax({
            url: '/cards/' +card_id+'/move',
            type: "PATCH",
            data: data,
            dataType: "json",
          })
      },

      startEditing: function() {
        this.editing = true,
        this.$nextTick(() => {this.$refs.message.focus()})
      }
    }
}
</script>

<style scoped>



</style>