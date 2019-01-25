<template>
<div>     
  <div class="card white" style="margin-top: 2%;">
    <div class="card-body" style="display:inline-flex">
      <table class="table" style="border:none; background-color:white;margin-top:0px;margin-bottom:0px; border-radius: 15px; font-family: Roboto, Helvetica, sans-serif; margin-left: 20px;">

        <th class="col-md-4" style="border: none">
          <div class="drop-down">
            <div class="selected" style="padding-right: 10px;">
              <Dropdown
                  :options="client_list"
                  v-on:selected="printClientId"
                  :data="client_list.id"
                  :disabled="false"
                  placeholder="Select a client"
                  style="border:none;height:80px;width:300px;font-size:22px;">
              </Dropdown>
            </div> 
          </div>
        </th> 

        <th class="col-md-4" style="border: none">
          <div class="drop-down">
            <div class="selected" style="none">
              <a @click="showTagList" style="text-align:center;width: 250px;border-radius: 5px;color: #a1a1a1;font-weight: lighter;font-size: 18px;text-decoration: none;font-family:arial;padding-top:7px;padding-left:1%;display: block;padding-right:20px;height: 50px; background-color:white;cursor:pointer">{{dropdownTagValue}}</a>
            </div>
            <div v-if="showTag == true" class="options" style="position:relative;">
              <ul style="z-index: 10000;background:#fff none repeat scroll 0 0;list-style:none; padding:0px 0px;position:absolute; left:0px; top:0px; width:auto; min-width:170px;border:1px solid #d7d7d7;">
                <li><a @click="clearTagId" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: #a1a1a1;font-size: 22px;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;"></a></li>
                <li v-for="tag in tags"><a @click="printTagId" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: flex;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;" :data-tag="tag.id"><span :style="{'color': tag.colour}" style="font-size: 80px; margin-left:22%;margin-right: 10%">•</span>{{tag.name}}</a></li>
              </ul>
            </div>
          </div>
        </th> 

        <th class="col-md-4" style="border: none">
          <div class="drop-down">
            <div class="selected" style="none">
              <a @click="showClientList" style="text-align:center;width: 250px;border-radius: 5px;text-decoration: none;color: #a1a1a1;font-weight: lighter;font-size: 18px;font-family:arial;padding-top:7px;padding-left:1%;display: block;padding-right:20px;height: 50px; background-color:white;"><span @click="showClientList">{{dropdownValue}}</span><i class="fa fa-caret-down pull-right" style="margin-top: 5px;"></i></a>
            </div>
            <div v-if="showList == tre" class="options" style="position:relative;">
              <ul style="z-index: 10000;background:#fff none repeat scroll 0 0;list-style:none;  padding:0px 0px;position:absolute; left:0px; top:0px; width:auto; min-width:170px;border:1px solid #d7d7d7;">
                <li v-for="client in client_list"><a @click="" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;" :data-id="client.id">{{client.name}}</a></li>
              </ul>
            </div>
          </div> 
        </th> 


      </table>
    </div>
  </div>
  <!-- Filter Menu   -->
 

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
    <div class="col-md-11" style="overflow-x: scroll">
      <div v-if="showClient == true">
        <draggable v-model="lists" :options="{group: 'lists'}" class='row dragArea' style="min-width: 1400px;margin-left:1%;margin-top: -0.5%;" @end="listMoved">
          <lists v-for="(list, index) in lists"  v-if="list.client_id == clientId" :list="list" :listId="list.id"  :clientId="selectedClientId" :cards="card_list" ></lists>
            <div v-if="newList == false" style="width: 500px;padding-right: 20%;margin-top: 4%;">
              <div @click="startEditing" class='col-md-3 card card-body fix' style="min-width: 350px;background-color: rgba(0, 0, 0, 0.1);margin-top: 28%;margin-right: 10%;" > Add a list ... </div>
            </div>
            <div v-else>
              <div class='col-md-1 card card-body fix' style="width: 1050px; background-color:rgba(0, 0, 0, 0.2);" >
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
  import Dropdown from 'vue-simple-search-dropdown';

  export default {

    props: ["original_time_cards", "tag_list", "original_lists", "cards", "clients"],
    components: { draggable, lists, Dropdown },
    data: function() {
      return {
        clientFilter: '',
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
        console.log(event.id)
        this.selectedClientId = event.id
        this.clientName = event.name
        console.log(this.selectedClientId)
        console.log(this.clientName)
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

.dropdown .dropdown-content {

    position: absolute;
    background-color: #fff;
    min-width: 400px;
    max-width: 400px;
    z-index: 1;
    font-size: 22px;

}

.dropdown .dropdown-input {

    background: #fff;
    cursor: pointer;
    border: 0px !important;
    border-radius: 0px !important;
    color: #333;
    display: block;
    font-size: .8em;
    padding: 6px;
    min-width: 450px;
    max-width: 250px;
    min-height: 100%;

}

  </style>