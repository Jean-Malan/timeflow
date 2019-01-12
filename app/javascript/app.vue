// app/javascript/components/app.vue
<template>
<div class="container">
    <draggable v-model="lists" :options="{group: 'lists'}" class='row dragArea' style="margin-left:5%" @end="listMoved">
      <lists v-for="(list, index) in lists" :list="list"></lists>

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
</template>

<script>
 
import draggable from 'vuedraggable'
import lists from 'components/list'

  export default {

    components: { draggable, lists },

    props: ["original_lists"],
    data: function() {
      return {
        lists: this.original_lists,
        editing: false,
        message: "",
        newList: false,
        listName: ""
      }
    },  

    methods: {


    startEditing: function() {
          this.newList = true
          // console.log(event)
        },

      listMoved: function(event){
        var data = new FormData
        var listings = this.lists[event.newIndex].id
        data.append("listing[position]", event.newIndex + 1)

        Rails.ajax({
          url: '/listings/'  +listings+'/move',
          type: "PATCH",
          data: data,
          dataType: "json",
        })
      },

      createNewList: function(event) {
        var data  = new FormData;
        data.append("listing[name]", this.message)
        data.append("listing[client_id]", parseInt(window.store.client))

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
      },
    },
  }

</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }

  .dragArea {
    min-height: 20px;
    background-color: aliceblue;
  }

  .row {
   
    overflow-x: scroll; /* Add vertical scrollbar */
    display: inline-flex !important;
  }
.body{
   background-color: #89bdd3 !important;
}
  .list {
    vertical-align: top !important;
  }

.card .card-body .card-dark {
    background-color: #89bdd3;
  }




.col-md-3 {
  background-color: #89bdd3;
  border-style: solid;
  border-color: #89bdd3;
  border-radius: 20px;
  border: 10px;
}




</style>