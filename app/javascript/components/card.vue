<template>
<div>
  <div @click="openModal" class="card card-body" :style="{'border-left-color': card.tag.colour}" :data-id="card.id" :parent-id="card.listing_id" style="margin-top:10px;margin-top: 10px;min-height: 120px;border-left-style: solid;border-left-width: 10px;">
    <div v-for="tag in tags" :style="{'background-color': tag.colour}" v-if="tag.id == card.tag_id" class="drop" value="0" style=";margin-left:0%; border-radius:10px"></div>
    {{card.name}}
  </div>
  
  <div v-if="editing" class="modal-backdrop show" :data-id="card.id" :data-listing-id="card.listing_id"></div>
    <div v-if="editing" @click="closeModal" class="modal show" style="display: block">
      <div class="card card-sm text-center" style="width: 50%;margin-left: 30%;margin-top: 5%;">
        <ul class="nav nav-tabs" style="margin-left: 25%;">
          <li class="nav-item" style="color: #8c8c8c">
            <button style="color: white" @click="showTagModal" class="btn btn-success" href="#">Tags</button>
          </li>
          <li class="nav-item">
            <button style="color: white;background-color:#377382;" class="btn btn-info" @click="showTime">TimeSheet</button>
          </li>
          <li class="nav-item">
            <button style="color: white" class="btn btn-danger" href="#">Disabled</button>
          </li>
        </ul>
        <div class="card-body" style="margin-left: -10% !important;margin-right: -30%;">
          <div class="col-md-9">

          <!-- Modal Timesheet -->
            <div v-if="showTimeSheet==true">
              <table class="table" style="margin-left:11%">
                <thead>
                  <tr>
                    <th scope="col">#</th>
                    <th scope="col">Description</th>
                    <th scope="col">Time</th>
                    <th scope="col">Created At</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="item in timeCard" v-if="item.card_id == card.id">
                      <th scope="row">{{item.id}}</th>
                      <td>{{item.description}}</td>
                      <td id="getTime">{{item.total_time}}</td>
                      <td>{{item.created_at}}</td>
                  </tr>
                  <tr>
                    <th scope="col"></th>
                    <th scope="col"></th>
                    <th scope="col">{{total}}</th>
                    <th scope="col"></th>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <!-- Modal Desicription    -->
          <div v-if="showTagBody==true">
            <div v-for="tag in tags" :style="{'background-color': tag.colour}" v-if="tag.id == card.tag_id"  class="drop grid-item" value="0" style="width: 60%; height:50px; color:white;margin-left:12%;font-weight:bold; font-size:13px;margin-bottom:20%; border-radius: 10px; margin-bottom: 10%;"></div>
              
              <div v-if="showTags" style="display: flex; margin-right:22%;margin-left: 5%;" >  
                <div v-for="tag in tags" :style="{'background-color': tag.colour}" @click="addTag" :data-id="tag.id" class="drop" value="0" style="width: 20%; height:55px; color:white;font-weight:bold;font-size:13px;margin-left:3%;border-radius:10px">
                  <p></p></div>
            </div>
          </div>
          <div class="modal-footer" style="margin-right: 200px;">
            <button class="btn btn-primary" v-if="showTagBody == true" @click="showTags=!showTags" style="margin-top:50px;">Change Tag</button>
            <button class="btn btn-primary" @click="editing=false" style="margin-top:50px;">Close</button>
          </div>
        </div>
      </div>
    </div>
  </div> 
</div> 


  
</template>

  <script>
    import Swatches from 'vue-swatches'
    import "vue-swatches/dist/vue-swatches.min.css"
    import dropdown from 'vue-dropdowns';

    export default {
      components: { dropdown },
      props: ['card', 'tag_list', "card_list"],
      data: function() {
        return {
          modal: '',
          color: '#194d33',
          cardId: '',
          parentId: '',
          showTagBody: true,
          showTimeSheet: false,
          editing: false,
          name: this.card.name,
          id: this.card.id,
          tags: window.store.tags,
          showTags: false,
          timeCard: window.store.timeCards,
          total: '',
          listingId: '',
          cardListing: this.card_list
        }
      },
      methods: {
        getModal: function() {
          console.log(this.modal)
        },
        getColor: function(event){
          console.log(this.color)
          var data = new FormData
          data.append('card[card_color]', this.color)
          console.log(this.cardId)

          Rails.ajax({
            url: '/cards/'+this.cardId,
            type: "PATCH",
            data: data,
            dataType: "json",
            success: (data) => {
              const listing_index = window.store.lists.findIndex((item) => item.id == this.parentId)
              const card_index = window.store.lists[listing_index].cards.findIndex((item) => item.id == this.cardId)
              window.store.lists[listing_index].cards[card_index].card_color = this.color
            }
          })
        },
        addTag: function(event){
          var card_id = this.cardId
          var listing_id = this.parentId
          var tag_id = event.target.attributes[1].value
          // var list_id = window.store.lists.findIndex((item) => item.id = listing_id)
          var card = card_list.findIndex((item) => item.id == card_id)
          var data = new FormData
          data.append('card[tag_id]', tag_id)

          Rails.ajax({
            url: '/cards/'+this.cardId,
            type: "PATCH",
            data: data,
            dataType: "json",
            success: (data) => {
              this.card_list[card].tag_id = tag_id
            }
          })
          // console.log(card)
          // console.log(window.store.list[list].card[card])
          // console.log(event.target.style["background-color"])
        },
        showTime: function(){
         this.showTimeSheet = true
         this.showTags = false
         this.showTagBody = false
         console.log()
        },
        showTagModal: function(){
         this.showTimeSheet = false
         this.showTags = false
         this.showTagBody = true
         console.log()
        },
        printId: function(event) {
          console.log(this.target)
        },
        closeModal: function(){},
        openModal(event) {
          this.editing = true
          console.log(event.target.attributes[1].value)
          console.log(event.target.attributes)
          this.cardId = event.target.attributes[1].value
          this.parentId = event.target.attributes[2].value
        },
        save: function(event) {
          console.log(event)
          var listing_id = event.target.dataset.listId
          var card_id = this.card.id
          var data = new FormData
          data.append("card[name]", this.name)

          Rails.ajax({
            url: '/cards/'+card_id,
            type: "PATCH",
            data: data,
            dataType: "json",
            success: (data) => {
              const list_index = window.store.lists.findIndex((item) => item.id == listing_id)
              const card_index = window.store.lists[list_index].cards.findIndex((item) => item.id === card_id)
              window.store.lists[list_index].cards.splice(card_index, 1, data)

              this.editing = false
            }
          })
        },
        formatTime: function(time) {
        if(time >= 3600){
          var formattedTime = parseInt(time) / 60;
          var formattedTimeString = formattedTime.toString();
          var fullHours = parseInt((time.toString().split(".")[0]) / 60) / 60;
          var formattedHours = parseInt(fullHours.toString().substring(0,2));
          var minutes = parseInt((time.toString().split(".")) / 60) / 60;
          var formattedMinutes = parseInt(((parseInt(min.toString().split(".")[1].substring(0,2)) / 100) * 60).toString().split(".")[0]);
          if(formattedTimeString.indexOf(".") > 0) {
            var seconds = (parseInt(formattedTime.toString().split(".")[1].substring(0,2)) / 100) * 60
            formatedSeconds = parseInt(seconds.toString().split(".")[0])
          } else {
            formatedSeconds = "00"
          } 
          if (formattedHours < 10){
            formattedHours = "0"+formattedHours
          }
          if (formattedMinutes < 10){
            formattedMinutes = "0"+formattedMinutes
          }
          if (formatedSeconds < 10){
            formatedSeconds = "0"+formatedSeconds
          }
          return formattedHours + ":" + formattedMinutes + ":" + formatedSeconds
        }
        if(time < 3600 && time >= 60) {
          var formattedTime = parseInt(time) / 60
          var formattedTimeString = formattedTime.toString()
          var minutes = parseInt(formattedTime.toString().split(".")[0])
          if(formattedTimeString.indexOf(".") > 0) {
            var seconds = (parseInt(formattedTime.toString().split(".")[1].substring(0,2)) / 100) * 60
            var formatedSeconds = parseInt(seconds.toString().split(".")[0])
          } else {
            var formatedSeconds = "00"
          } 
          if (minutes < 10){
            minutes = "0"+minutes
          }
          if (formatedSeconds < 10){
            formatedSeconds = "0"+formatedSeconds
          }
          return "00:"+minutes+":"+formatedSeconds
        }
        if(time < 60 && time > 10) {
          return "00:00:"+time
        } else {
          return "00:00:"+"0"+time
        }
      }
    },
    watch: {
      modal: function(){
        var card_id = this.cardId
        var listing_id = this.parentId
        var tag_id = event.target.attributes[1].value
        var list_id = window.store.lists.findIndex((item) => item.id = listing_id)
        var card = window.store.lists[list_id].cards.findIndex((item) => item.id == card_id)
        cardTagId = window.store.lists[list_id].cards[card].tag_id
        tag = window.store.tags.findIndex((item) => item.id == cardTagId)
        this.modal = window.store.tags[tag].colour
      }
    }
  }
    

  </script>

  <style scoped>


  </style>