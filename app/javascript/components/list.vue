<template>

  <div class='col-md-3 align-top card card-body fix grey' :data-index="list.id">
    <strong> <p class="text-center">{{list.name}}</p></strong>
    <hr />

    <draggable v-model="list.cards" :options="{group: 'cards'}" class='dragArea' @end="cardMoved" style="min-height:30px; margin-left:20px !important;">
      <card v-for="(card, index) in list.cards" :card="card" :data-id="card.id"> </card>   
    </draggable>
    <div class="element1">
      <i class="fa fa-plus" v-if="!editing" @click="startEditing"></i>
    </div>
    <div class="element2">
      <div v-if="list.cards.length <= 0">
        <i class="fa fa-trash pull-right" v-if="!editing" @click="deleteList"></i>
      </div>
    </div>
    <div v-if="editing" class="card card-body card-dark" style="margin-top: 10%;">
      <textarea :listId="list.id" v-model="message" ref="message" class="form-control"></textarea>
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
    props: ["list", "clientId"],
    data: function() {
       return {
        client: this.clientId,
        editing: false,
        message: ""
      }
    },
    methods: {
      submitMessages: function(event) {
        console.log(this.client)
        var data  = new FormData;
        console.log(window.store.client)
        var listing_id = event.target.dataset.index 
        data.append("card[listing_id]", listing_id);
        data.append("card[name]",this.message);
        data.append("card[tag_id]", 1);
        data.append("card[client_id]", parseInt(window.store.client))

        Rails.ajax({
          url: "/cards",
          type: "POST",
          data: data,
          dataType: "json",
          success: (data) => {
            const index = window.store.lists.findIndex(item => item.id == this.list.id);
            window.store.lists[index].cards.push(data)
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
          console.log(event)
          console.log(event.explicitOriginalTarget.attributes[1].value)
          var new_column = (event.to.firstElementChild.offsetParent.dataset.index)
          var card_id =  (event.clone.dataset.id)
          var new_position =  (event.newIndex + 1)
          console.log(event)

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