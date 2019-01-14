<template>
<div>
  <div class="row">
    <div class="col-md-3 dragArea" style="min-height: 1500px;border-color: grey;border-style: none;border-width: 0px 2px 0px 0px;border-radius: 0px;border-style: solid;">
      <draggable v-model="card_list" :options="{group: card_list}">
        <div :data-client="card.client_id" style="margin-bottom:10px" v-for="card in  card_list" class="to-do-card" @click="printCards">
          <div class="to-do-card-label" :style="{'background-color': card.tag.colour,'border-color': card.tag.colour}" style="border-width:2px;border-style:solid">
            <p style="position:overlay; margin-left: 150%;padding-top: 50%; font-size: 1em;width: 200%;" :style="{'color': card.tag.colour }">{{card.name}}</p>
          </div>
        </div>
      </draggable>
    </div>

    <div class="col-md-9">
      <div v-if="showClient == true">
        <draggable v-model="lists" :options="{group: 'lists'}" class='row dragArea' style="margin-left:5%;margin-top: -1%;" @end="listMoved">
          <lists :clientId="clientId" v-for="(list, index) in lists" :list="list" v-if="list.client_id == clientId" :listID="list.id"></lists>
            <div v-if="newList == false">
              <div @click="startEditing" class='col-md-3 card card-body fix' style="width: 1050px; background-color:rgba(0, 0, 0, 0.1);" > Add a list ... </div>
            </div>
            <div v-else>
              <div class='col-md-3 card card-body fix' style="width: 1050px; background-color:rgba(0, 0, 0, 0.2);" >
                <input v-model="message" ref="message" placeholder="List name" class="form-control" style="background-color: #ededed">
                <button class="btn btn-danger" @click="createNewList">Save</button>
                <a @click="newList=false"> Cancel </a>
              </div>
            </div>
        </draggable>    
      </div>
    </div>
  </div>
</div>


</template>

<script>
  import draggable from 'vuedraggable'
  import lists from '../components/list'
  import "vue-swatches/dist/vue-swatches.min.css"

  export default {

    props: ["original_time_cards", "tag_list", "original_lists", "cards"],
    components: { draggable, lists },
    data: function() {
      return {
        color: '#194d33',
        tags: this.tag_list,
        lists: this.original_lists,
        card_list: window.store.cards,
        editing: false,
        message: "",
        newList: false,
        listName: "",
        timer: null,
        totalTime: (0 * 0),
        resetButton: false,
        title: "Countdown to rest time!",
        edit: false,
        clientId: '',
        showClient: false
      }
    },
    methods: {
      getColor: function(event){
        console.log(event)
      },
        printCards: function(event){
          console.log(event.target.dataset.client)
          console.log(event)
          this.clientId = event.target.dataset.client
          this.showClient = true
        },
        updateValue: function(value){
          console.log(value.rgba)
        },
        startEditing: function() {
          this.newList = true
          // console.log(event)
        },
        listMoved: function(event){
          var data = new FormData
          console.log(event)
          // var listings = this.lists[event.newIndex].id
          // data.append("listing[position]", event.newIndex + 1)

          // Rails.ajax({
          //   url: '/listings/'  +listings+'/move',
          //   type: "PATCH",
          //   data: data,
          //   dataType: "json",
          // })
        },

        createNewList: function(event) {
          console.log(this.clientId)
          var data  = new FormData;
          data.append("listing[name]", this.message)
          data.append("listing[client_id]", this.clientId)

          Rails.ajax({
            url: "/listings",
            type: "POST",
            data: data,
            dataType: "json",
            success: (data) => {
              window.store.lists.push(data)
              this.message = ""
              this.newList = false
            }
          })
        }
      }
  }


  </script>

  <style>


  </style>