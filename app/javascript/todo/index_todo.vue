<template>
<div>

  <!-- Filter Menu   -->
  <div class="card row" style="width: 70%;height: 50px;margin-left: 15%;">
    <div class="row" style="margin-top:0px;margin-bottom:3px;margin-left: 17%;">
      <div class="drop-down">
        <div class="selected" style="padding-right: 10px;">
          <a @click="showClientList" style="text-align:center;width: 250px;border-radius: 5px;text-decoration: none;color:black;font-family:arial;padding-top:7px;padding-left:1%;display: block;padding-right:20px;height: 50px; background-color:white;"><span @click="showClientList">{{dropdownValue}}</span><i class="fa fa-caret-down pull-right" style="margin-top: 5px;"></i></a>
        </div>
        <div v-if="showList == true" class="options" style="position:relative;">
          <ul style="z-index: 10000;background:#fff none repeat scroll 0 0;list-style:none;  padding:0px 0px;position:absolute; left:0px; top:0px; width:auto; min-width:170px;border:1px solid #d7d7d7;">
            <li><a @click="clearClientId" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;"></a></li>
            <li v-for="client in client_list"><a @click="printClientName" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;" :data-id="client.id">{{client.name}}</a></li>
          </ul>
        </div>
      </div>

        <div class="drop-down">
          <div class="selected" style="none">
            <a @click="showTagList" style="text-align:center;width: 250px;border-radius: 5px;text-decoration: none;color:black;font-family:arial;padding-top:7px;padding-left:1%;display: block;padding-right:20px;height: 50px; background-color:white;"><span @click="showTagList">{{dropdownTagValue}}</span><i class="fa fa-caret-down pull-right" style="margin-top: 5px; cursor:pointer"></i></a>
          </div>
          <div v-if="showTag == true" class="options" style="position:relative;">
            <ul style="z-index: 10000;background:#fff none repeat scroll 0 0;list-style:none; padding:0px 0px;position:absolute; left:0px; top:0px; width:auto; min-width:170px;border:1px solid #d7d7d7;">
              <li><a @click="clearTagId" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;"></a></li>
              <li v-for="tag in tags"><a @click="printTagId" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: flex;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;" :data-tag="tag.id"><span :style="{'color': tag.colour}" style="font-size: 80px; margin-left:22%;margin-right: 10%">•</span>{{tag.name}}</a></li>
            </ul>
          </div>
        </div>

      <div class="drop-down">
        <div class="selected" style="none">
          <a @click="showClientList" style="text-align:center;width: 250px;border-radius: 5px;text-decoration: none;color:black;font-family:arial;padding-top:7px;padding-left:1%;display: block;padding-right:20px;height: 50px; background-color:white;"><span @click="showClientList">{{dropdownValue}}</span><i class="fa fa-caret-down pull-right" style="margin-top: 5px;"></i></a>
        </div>
        <div v-if="showList == 'ss'" class="options" style="position:relative;">
          <ul style="z-index: 10000;background:#fff none repeat scroll 0 0;list-style:none;  padding:0px 0px;position:absolute; left:0px; top:0px; width:auto; min-width:170px;border:1px solid #d7d7d7;">
            <li v-for="client in client_list"><a @click="" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;" :data-id="client.id">{{client.name}}</a></li>
          </ul>
        </div>
      </div> 
    </div>
  </div>

  <!-- Card List   -->
  <div class="row">
    <i v-if="showClientCard == false" @click="showClientCard= !showClientCard" style="margin-left: 20px;margin-top: -3%;" class="fa fa-arrow-right"></i>
    <i v-if="showClientCard == true" @click="showClientCard= !showClientCard" style="margin-left: 20px;margin-top: -3%;" class="fa fa-arrow-left"></i>
    <div v-if="showClientCard == true">
      <div class="col-md-3 dragArea" style="margin-left: 20px !important;overflow-y: scroll;max-height: 850px;width: 100%;min-width: 450px;overflow-x: hidden">
        <draggable v-model="card_list" :options="{group: card_list}">
          <div :data-client="card.client_id" :style="{'border-left-color': card.tag.colour}" style="min-width: 400px;margin-top: 5px;min-height: 120px;border-left-style: solid;border-left-width: 10px;background-color:white" v-for="card in  card_list"  v-if="card.tag_id == selectedTagId || card.client_id == selectedClientId" class="to-do-card" @click="printCards">
            <div class="to-do-card-label">
              <p :data-client="card.client_id" @click="printCards" style="position:overlay; margin-left: 50%;padding-top: 20%; font-size: 1em;width: 1000%;"><strong>Card Name: </strong> {{card.name}} <br> <strong>Client Name: </strong>{{card.client.name}}</p>
              <p  :data-client="card.client_id" @click="printCards" style="position:overlay; margin-left: 50%;font-size: 1em;width: 1000%;"><strong>Due Date: </strong> 1 February 2019</p>
            </div>
          </div>
        </draggable>
      </div>
    </div>

  <!-- Draggable Listing   -->
    <div class="col-md-9" style="overflow-x: scroll">
      <div v-if="showClient == true">
        <draggable v-model="lists" :options="{group: 'lists'}" class='row dragArea' style="min-width: 1400px;margin-left:1%;margin-top: -1%;" @end="listMoved">
          <lists v-for="(list, index) in lists"  v-if="list.client_id == clientId" :list="list" :listId="list.id"  :clientId="selectedClientId" :cards="card_list" ></lists>
            <div v-if="newList == false">
              <div @click="startEditing" class='col-md-3 card card-body fix' style="width: 1050px; background-color:rgba(0, 0, 0, 0.1);margin-top: 10%;" > Add a list ... </div>
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

  export default {

    props: ["original_time_cards", "tag_list", "original_lists", "cards", "clients"],
    components: { draggable, lists },
    data: function() {
      return {
        color: '#194d33',
        tags: this.tag_list,
        lists: this.original_lists,
        client_list: this.clients,
        card_list: window.store.cards,
        editing: false,
        selectedClientId: '',
        message: "",
        newList: false,
        listName: "",
        timer: null,
        totalTime: (0 * 0),
        resetButton: false,
        title: "Countdown to rest time!",
        edit: false,
        clientId: '',
        showClient: false,
        showList: false,
        dropdownValue: "Filter Client",
        dropdownTagValue: "Filter Tag",
        showClientCard: true,
        selectedTagId: '',
        showTag: false
      }
    },
    methods: {
      clearTagId: function() {
        this.selectedTagId = 0
        this.showTag = !this.showTag
      },
      clearClientId: function() {
        this.selectedClientId = 0
        this.dropdownValue = "Filter Client",
        this.showList = !this.showList
      },
      printClientName (event) {
        console.log(event.target.text)
        this.selectedClientId = event.target.dataset.id
        this.dropdownValue = event.target.text
        this.showList = false
      },
      printTagId (event) {
        console.log(event.target.dataset.tag),
        this.dropdownTagValue = event.target.text,
        this.showTag = false,
        this.selectedTagId = event.target.dataset.tag
      },
      showTagList (event) {
        this.showTag = !this.showTag
      },
      showClientList () {
        this.showList = !this.showList
      },
      printClientId: function(event) {
        var chosenClient = event.target.selectedIndex
        var chosenClientId = event.srcElement[chosenClient].firstChild.attributes['data-client-id'].value
        this.selectedClientId = parseInt(chosenClientId)
        this.clientName = event.target.value
        this.showClient = true
        console.log(this.clientName)
        console.log(this.selectedClientId)
      },
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
*{
  margin:0;
  padding:0;
}

.drop-down{
  position:absolute;
  left:42%;
  top:40%;
}

.drop-down .selected a{
  background:#fff no-repeat scroll right center;
  display:block; 
  padding-right:20px; 
  border:1px solid #d7d7d7; 
  width:150px;
  border-radius:2px;
  text-decoration:none;
  color:#3179ac;
  font-family: arial, lobster;
}

.drop-down .selected a span{
  cursor:pointer; 
  display:block; 
  padding:5px;
}

.drop-down .option{
  position:relative; 
}

.drop-down .options ul{
  background:#fff none repeat scroll 0 0;
  list-style:none; 
  padding:0px 0px; 
  position:absolute; 
  left:0px; 
  top:32px; 
  width:auto; 
  min-width:170px;
  border:1px solid #d7d7d7;
}


.drop-down .options ul li a{
  padding:5px; 
  display:block;
  text-decoration:none;
  color:#3179ac;
  font-family: arial, lobster;
}

.drop-down .options ul li a:hover{
  background:#3179ac;
  color:#fff;
  transition:0.2s ease;
}

  </style>