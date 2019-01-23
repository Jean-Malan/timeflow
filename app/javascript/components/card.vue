<template>
<div>

  <div @click="editing = !editing" class="card card-body" :style="{'border-left-color': card.tag.colour}" :data-id="card.id" :parent-id="card.listing_id" style="margin-top:10px;margin-top: 10px;min-height: 120px;border-left-style: solid;border-left-width: 10px;">
    <div v-for="tag in tags" :style="{'background-color': tag.colour}" v-if="tag.id == card.tag_id" class="drop" value="0" style=";margin-left:0%; border-radius:10px"></div>
    <div class="to-do-card-label">
      <p style="position:overlay; margin-left: 50%;padding-top: 0%; font-size: 1em;width: 1000%;"><strong>Card Name: </strong> {{card.name}} <br> <strong>Client Name: </strong>{{card.client.name}}</p>
      <p style="position:overlay; margin-left: 50%;font-size: 1em;width: 1000%;"><strong>Due Date: </strong> 1 February 2019</p>
    </div>
  </div>
  
  <div v-if="editing" class="modal-backdrop show" :data-id="card.id" :data-listing-id="card.listing_id"></div>
    <div v-if="editing" @click="closeModal" class="modal show" style="display: block">
      <div class="card card-sm text-center" style="width: 40%;margin-left: 60%;padding-top: 5%;height: 100%;">
        <div class="card-body" style="">
          <div>


          <!-- Modal Timesheet -->
            
          <div style="margin-left: 0%;width: 100%;height: 45px;margin-top: -140px;margin-bottom: 10%;" :style="{'background-color': card.tag.colour}">Hi</div>

          <form class="col-md">
            <div class="form-group" style="display: flex;">
              <label class="col-md-3" for="exampleFormControlInput1">Select Label</label>
                  <div class="col-md-9" style="">
                    <div class="drop-down">
                      <div class="selected" style="padding-right: 10px;">
                        <a @click="showList = true" style="margin-left: 3%;text-align:center;width: 450px;border-radius: 5px;text-decoration: none;color:black;font-family:arial;padding-top:7px;padding-left:1%;display: block;padding-right:20px;height: 50px; background-color:rgb(218, 218, 218);"><span @click="showList = true"></span><i class="fa fa-caret-down pull-right" style="margin-top: 5px;"></i></a>
                      </div>
                      <div v-if="showList == true" class="options" style="position:relative;">
                        <ul style="z-index: 10000;background:#e3e3e3 none repeat scroll 0 0;list-style:none;  padding:0px 0px;position:absolute; left:0px; top:0px; width:auto; min-width:170px;border:1px solid #d7d7d7;">
                          <li><a @click="showList = false" style="background:#e3e3e3, text-align:center;z-index=1000;width: 450px;padding: 5px;display: block;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;"></a></li>
                          <li v-for="tag in tags"><a @click="printTagId" style="text-align:center;z-index=1000;width: 450px;padding: 5px;display: block;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;" :style="{'background-color': tag.colour}" :data-id="tag.id"></a></li>
                        </ul>
                      </div>
                    </div>
                </div>
            </div>


            <div class="form-group col-md" style="display:flex;">
              <label class="col-md-3" for="exampleFormControlSelect1" style="">Select Date</label>
                <date-picker v-model="time1"  class="col-md-6" style="height:45px;width: 450px;margin-left: -3%;" placeholder="Start Time" lang="en" type="date" format="YYYY-MM-DD" ></date-picker>
            </div>
          </form>


            <div style="margin-top:10%">
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


          <!-- Modal Tags    -->
          <div @click="editing = false"class="btn btn-default" style="margin-top:5%">Close</div>
        </div>
      </div>
    </div>
  </div> 
</div> 


  
</template>

  <script>
    import DatePicker from 'vue2-datepicker'
    import Swatches from 'vue-swatches'
    import "vue-swatches/dist/vue-swatches.min.css"
    import dropdown from 'vue-dropdowns';

    

    export default {
      components: { dropdown, DatePicker },
      props: ['card', 'tag_list', "card_list"],
      data: function() {
        return {
          showList: false,
          time1: '',
          time2: '',
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
          cardListing: this.card_list,
          panel1Form: {
            openOn: "right"
          }
        }
      },
      methods: {
        printTagId (event) {
          console.log(this.id)
          console.log(event.target.dataset.id)
          var card_id = this.id
          var tag_id = event.target.dataset.id
          var card = window.store.cards.findIndex((item) => item.id == card_id)

          var data = new FormData
          data.append('card[tag_id]', tag_id)

           Rails.ajax({
            url: '/cards/'+this.cardId,
            type: "PATCH",
            data: data,
            dataType: "json",
            success: (data) => {
              window.store.cards[card].tag_id = tag_id
              this.showList = false
            }
          })
        },
        somethingClicked: function () {
          this.$children[0].slideout.toggle()
        },
        getModal: function() {
          console.log(this.modal)
        },
        getColor: function(event){
          console.log(this.color)
          var data = new FormData
          data.append('card[card_color]', this.color)
          console.log(this.cardId)

          Rails.ajax({
            url: '/cards/'+this.id,
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
          var card_id = this.id
          var listing_id = this.parentId
          var tag_id = event.target.attributes[1].value
          // var list_id = window.store.lists.findIndex((item) => item.id = listing_id)
          var card = card_list.findIndex((item) => item.id == card_id)
          var data = new FormData
          data.append('card[tag_id]', tag_id)

          Rails.ajax({
            url: '/card/'+this.id,
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
    .slideout-menu {
    position: fixed;
    top: 0;
    bottom: 0;
    width: 256px;
    height: 100vh;
    overflow-y: scroll;
    -webkit-overflow-scrolling: touch;
    z-index: 0;
    display: none;
    background-color: #1D1F20;
    color: white;
  }

  .slideout-menu-left {
    left: 0;
  }

  .slideout-menu-right {
    right: 0;
  }

  .slideout-panel {
    background-color: #4B5;
    color: white;
    position: relative;
    z-index: 1;
    will-change: transform;
    min-height: 100vh;
  }

  .slideout-open,
  .slideout-open body,
  .slideout-open .slideout-panel {
    overflow: hidden;
  }

  .slideout-open .slideout-menu {
    display: block;
  }


  </style>