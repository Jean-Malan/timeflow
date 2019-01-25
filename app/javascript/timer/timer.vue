<template>
<div class="card white" style="margin-top: 2%;">

    <div class="card-body">
      <span>
        <table style="width: 100%">
          <tr>
            <thead>
              <th class="col-md-6">
                <input ref="description" v-model="timeDescription" placeholder="Description" v-on:change="getDescription"  style="width: 100%; height:40px; background-color: rgba(0,0,0,0);color: #5e5e5e; font-size:20px">
              </th>

              <th class="col-md-3">
                <div class="drop-down">
                  <div class="selected" style="padding-right: 10px;">
                    <!-- <a @click="openDropDown" style="text-align:center;width: 250px;border-radius: 5px;text-decoration: none;color: #5e5e5e;font-family:arial;padding-top:13px;padding-left:1%;display: block;padding-right:20px;height: 50px; background-color: white;font-size: 22px;font-weight: lighter;cursor: pointer;"><span @click="openDropDown">{{dropdownValue}}</span><i class="fa fa-caret-down pull-right" style="margin-top: 5px;"></i></a> -->
                    <i @click="openDropDown" style="margin-right: 15%;display: -webkit-inline-box;float: right;" class="fa fa-address-card"><div style="margin-top: 2%; font-size: 21px;font-weight: lighter;margin-left: 10%;">{{dropdownValue}}</div></i>
                  </div>
                  <div v-if="showList == true" class="options" style="position:relative;">
                    <ul  @click="openDropDown" style="z-index: 10000;background:#fff none repeat scroll 0 0;list-style:none;  padding:0px 0px;position:absolute; left:0px; top:0px; width:auto; min-width:170px;border:1px solid #d7d7d7;">
                      <li @click="openDropDownClear"><a @click="openDropDown" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: #5e5e5e;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;">Select a client</a></li>
                      <li v-for="client in clients" @click="openDropDown"><a @click="printClientId" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: #5e5e5e;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;"  :data-id="client.id">{{client.name}}</a></li>
                    </ul>
                  </div>
                </div>
              </th>

              <th class="col-md-3">
                <div class="drop-down">
                  <div class="selected" style="none">
                     <i @click="showCardList" style="margin-right: 15%;display: -webkit-inline-box; float: left;" class="fa fa-tag"><div style=" margin-top: 2%;font-size: 21px;font-weight: lighter;margin-left: 10%;">{{dropdownCardValue}}</div></i>
                    <!-- <a @click="showCardList" style="text-align:center;width: 250px;border-radius: 5px;font-weight: lighter;font-size:22px;text-decoration: none;color: #5e5e5e;font-family:arial;padding-top:13px;padding-left:1%;display: block;padding-right:20px;height: 50px;cursor:pointer; background-color:white;"><span @click="showCardList">{{dropdownCardValue}}</span><i class="fa fa-caret-down pull-right" style="margin-top: 5px; cursor:pointer"></i></a> -->
                  </div>
                  <div v-if="showCard == true" class="options" style="position:relative;">
                    <ul @click="showCardList" style="z-index: 10000;background:#fff none repeat scroll 0 0;list-style:none; padding:0px 0px;position:absolute; left:0px; top:0px; width:auto; min-width:170px;border:1px solid #d7d7d7;">
                      <li @click="showCardList"><a @click="showCardList" style="text-align:center;z-index=1000;width: 350px;padding: 5px;display: block;text-decoration: none;color: #5e5e5e;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;"></a></li>
                      <li v-for="card in cards" v-if="card.client_id == clientId" @click="showCardList"><a @click="getCardDetails" style="text-align:center;z-index=1000;width: 350px;padding: 5px;display: flex;text-decoration: none;color: #5e5e5e;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;" :data-cardId="card.id"><span :style="{'color': card.tag.colour}" style="font-size: 80px; margin-left:15%;margin-right: 10%">•</span>{{card.name}}</a></li>
                    </ul>
                  </div>
                </div>
              </th>

                <th class="col-md-1">
                  <div class="timepicker" v-if="timepicker==true">
                    <span style="display: inline-flex;">
                      <date-picker v-model="time1" @input="printTime1" style= "margin-left: 10%" placeholder="Start Time" lang="en" type="datetime" format="YYYY-MM-DD hh:mm:ss a" :time-picker-options="{ start: '00:00', step: '00:05', end: '23:55' }"></date-picker>
                      <date-picker v-model="time2" placeholder="End Time" style= "margin-left: 10%" lang="en" type="datetime" format="YYYY-MM-DD hh:mm:ss a" :time-picker-options="{ start: '00:00', step: '00:05', end: '23:55' }"></date-picker>
                    </span>
                  </div>
                  <div class="clocktimer" v-if="clockTimer==true">
                    <span style="display: inline-flex;">
                      <div style="margin-top: 7%;">  
                        <div class="start" v-if="showStart" @click="startTimer" style="margin-right:20px; margin-top:15%">
                          <i class='fa fa-play' data-feather="play" ></i>
                        </div>
                        <div class="pause" v-if="showPause" @click="pauseTimer" style="margin-right:20px;">
                          <i class='fa fa-pause' data-feather="pause"></i>
                        </div>
                        <div class="stop" v-if="timer" @click="stopTimer" style="margin-right:20px;">
                          <i class='fa fa-stop' data-feather="square"></i>
                        </div>
                      </div>
                      <span>
                        <div style="margin-top: 7%;color: #5e5e5e"><h2>{{ minutes }}:{{ seconds }}</h2></div>
                      </span>
                    </span>
                  </div>
                </th>
              
              <th class="col-md-1">
                <div class="container_row">
                  <div class="layer1">
                    <i @click="changetimer" class="fa fa-bars"></i>
                  </div>
                  <div class="layer2">
                    <i @click="changetimer" class="fa fa-clock"></i>
                  </div>
                </div>    
              </th>

            </thead>
          </tr>  
        </table>
      </span>  
    </div>

    <div v-if="editing" class="modal-backdrop show"></div>
    <div v-if="editing" class="modal show" style="display: block">
      <div class="card card-nav-tabs" style="width: 40%;margin-left: 35%;margin-top: 15%;">
        <div class="card-header card-header-warning">
          Featured
        </div>
        <div class="card-body">
          <select v-on:change="newClientId" ref="newClient">
            <option v-for="(card,index) in cards">
              <p :data="card.id">{{ card.name }} </p>
            </option>
          </select>
          <h4 class="card-title">Special title treatment</h4>
          <p class="card-text">With supporting text below as a natural lead-in to additional content.</p>
          <a @click="editing=false" class="btn btn-primary">Close</a>
        </div>
      </div>
    </div>
  </div>


</template>

<script>


  import DatePicker from 'vue2-datepicker'
  export default {

    props: ["client_list", "original_time_cards", "card_list"],
    components: { DatePicker },
    data: function() {
      return {
        timeDescription: '',
        value1: '',
        dropdownValue: " ",
        dropdownCardValue: " ",
        showList: false,
        showCard: false,
        newClientId: '',
        cardId: '',
        cardName: '',
        editing: false,
        showStart: true,
        showPause:  false,
        showTimer: false,
        clockTimer: true,
        timepicker: false,
        startTime: '',
        endTime: '',
        clientName: "",
        projectId: 0,
        projectName: "",
        time_cards: this.original_time_cards,
        clients: this.client_list,
        cards: this.card_list,
        editing: false,
        timer: null,
        totalTime: (0 * 0),
        resetButton: false,
        edit: false,
        description: "",
        time1: '',
        time2: '',
        time3: '',
        shortcuts: [{
          text: 'Today',
          onClick: () => {
            this.time3 = [ new Date(), new Date() ]
          }
        }],
        timePickerOptions:{
        start: '00:00',
        step: '00:30',
        end: '23:30'
        }
      }
    },  
    methods: {
      getCardDetails (event) {
        this.showCard = false
        this.projectId = event.target.dataset.cardid
        this.projectName = event.target.text.replace('•','');
        this.dropdownCardValue = this.projectName
        console.log(this.projectName)
        console.log(this.projectId)
      },
      showCardList () {
        this.showCard = !this.showCard
      },
      openDropDownClear () {
        this.showList = !this.showList
        this.dropdownValue = ' '
        this.clientName = ' '
        this.clientId = 0
      },
      openDropDown () {
        this.showList = !this.showList
      },
      printClientId (event) {
        this.showList = !this.showList
        this.dropdownValue = event.target.text
        this.clientName = event.target.text
        this.clientId = event.target.dataset.id
        console.log(this.clientId)
        console.log(this.clientName)
      },
      printTime1 () {
        var time = this.time1.toString()
        time = time.substr(15,9)
        this.saveManualCard(time)
      },
       saveManualCard: function (startTime) {
        var time = startTime.split(":")
        var hours = (parseInt(time[0]) * 3600 )
        var minutes = (parseInt(time[1]) * 60 )
        var seconds = parseInt(time[2])
        var totalTime = hours + minutes + seconds
        console.log(totalTime)
        console.log(this.formatTime(totalTime))
        // this.formatTime(totalTime)
      },
      changetimer () {
        this.clockTimer = !this.clockTimer,
        this.timepicker = !this.timepicker
      },
      formatTime: function(time) {
        if(time >= 3600){
          var formattedTime = parseInt(time) / 60;
          var formattedTimeString = formattedTime.toString();
          var fullHours = parseInt((time.toString().split(".")[0]) / 60) / 60;
          var formattedHours = parseInt(fullHours.toString().substring(0,2));
          var minutes = parseInt((time.toString().split(".")) / 60) / 60;
          var formattedMinutes = parseInt(((parseInt(minutes.toString().split(".")[1].substring(0,2)) / 100) * 60).toString().split(".")[0]);
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
      },
      clientId: function(client_id){
        console.log(client_id)
        this.newClientId = client_id
      },
      getDescription: function(event){
        this.description = this.timeDescription
        console.log(this.description)
      },
      getClientId: function(event){
        var chosenClient = event.target.selectedIndex
        var chosenClientId = event.srcElement[chosenClient].firstChild.attributes['data-client-id'].value
        this.clientId = parseInt(chosenClientId)
        this.clientName = event.target.value
        console.log(this.clientName)
        console.log(this.clientId)
      },
      getProjectId: function(event){
        var chosenProject = event.target.selectedIndex
        var chosenProjectId = event.srcElement[chosenProject].firstChild.attributes['data'].value
        this.projectId = chosenProjectId
        this.projectName = event.target.value
        console.log(this.projectName)
        console.log(this.projectId)
      },
      printItems: function() {
        console.log(this.original_time_cards)
      },
      startTimer: function() {
        this.showStart = false
        this.showPause = true
        this.timer = setInterval(() => this.countdown(), 1000); //1000ms = 1 second
        this.resetButton = true;
        this.startTime = new Date()
        console.log(this.startTime)
      },
      pauseTimer: function() {
        clearInterval(this.timer);
        this.showPause = false
        this.showStart = true
      },
      stopTimer: function() {
        this.showStart = true
        this.showPause = false
        clearInterval(this.timer);
        this.saveTimeCard()
        window.store.timeCardDates.push(this.formatDate(Date()))
        this.timer = null;
        this.resetButton = true;
        this.cardName = true;
        this.resetButton = true;
        console.log(this.totalTime)
        var description = "this.timeDescription"
        var client = this.clientName
        var project = this.projectName
        console.log(description)
        console.log(client)
        console.log(project)
        this.resetTimer()
      },
      resetTimer: function() {
        this.totalTime = (0 * 0);
        clearInterval(this.timer);
        this.timer = null;
        this.resetButton = false;
      },
      editTimer: function() {
        this.edit = true;
      },
      formatDate: function(date) {
        var d = date.substr(0,15)
        var month = d.substr(4,3)
        var day = d.substr(8,2)
        var year = d.substr(11,4)
        if(month == "Jan") {
          month = "01"
        }
        if(month == "Feb") {
          month = "02"
        }
        if(month == "Mar") {
          month = "03"
        }
        if(month == "Apr") {
          month = "04"
        }
        if(month == "May") {
          month = "05"
        }
        if(month == "Jun") {
          month = "06"
        }
        if(month == "Jul") {
          month = "07"
        }
        if(month == "Aug") {
          month = "08"
        }
        if(month == "Sep") {
          month = "09"
        }
        if(month == "Oct") {
          month = "10"
        }
        if(month == "Nov") {
          month = "11"
        }
        if(month == "Dec") {
          month = "12"
        }
        return year+"-"+month+"-"+day
      },
      padTime: function(time){
        return (time < 10 ? '0' : '') + time;
      },
      countdown: function() {
        this.totalTime++;
      },
      saveTimeCard: function(){
        this.endTime = new Date();
        var data = new FormData

        data.append("time_card[start_time]", this.startTime)
        data.append("time_card[recorded_time]", this.totalTime)
        data.append("time_card[description]", this.description)
        data.append("time_card[end_time]", this.endTime)
        data.append("time_card[client_id]", this.clientId)
        data.append("time_card[card_id]", this.projectId)

       
        window.store.timecards.push({client_id: this.clientName, description: this.description, created_at: this.formatDate(Date()), card_id: this.projectName, total_time: this.formatTime(this.totalTime)})
        window.store.timecards[window.store.timecards.length - 1].client = {name: this.clientName }
        window.store.timecards[window.store.timecards.length - 1].card = {name: this.projectName }

        var card_id = window.store.cards.findIndex((i) => i.id == this.projectId)
        var tag_id = window.store.cards[card_id].tag_id
        var tagIndex = window.store.tags.findIndex(item => item.id == tag_id)
        var tag = window.store.tags[tagIndex].colour

        window.store.timecards[window.store.timecards.length - 1].card.tag =  window.store.tags.findIndex(item => item.id == tag_id)
         window.store.timecards[window.store.timecards.length - 1].card.tag = {colour: this.projectName }

        Rails.ajax({
          url: '/time_cards',
          type: "POST",
          data: data,
          dataType: "json",
        })
      },
    },
    computed: {
      minutes: function(){
        const minutes = Math.floor(this.totalTime / 60);
        return this.padTime(minutes);
      },
      seconds: function() {
        const seconds = this.totalTime - (this.minutes * 60);
        return this.padTime(seconds);
      }
    },
    watch: {
      clientName: function() {
        if (this.clientName != "" ) {
          this.showTimer = true 
        }
      },
    }
  }


  </script>

  <style>

  input .mx-input {
    background-color: #fafaf9;
    border: none;
    width: 90%;
  }

  .mx-input-append {
    display: none
  }
  input .mx-input {
    background-color: aquamarine;
  }

  .container {
    max-width: 2000px;
  }

  .container_row{
  display: flex;
  }

  .layer1 {
    width: 100%;
    background-color: rgba(255,0,0,0.5);
  }

  .layer2{
    width: 100%;
    margin-left: -100%;
    background-color: rgba(0,0,255,0.5); 
  }



  </style>
