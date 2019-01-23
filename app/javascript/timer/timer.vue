<template>
<div class="card bg-info">
    <div class="card-body">
      <span>
        <table style="width: 100%">
          <tr>
            <thead>
                <th class="col-md-3">
                  <input ref="description" placeholder="Description" v-on:change="getDescription"  style="width: 1--%; height:40px; background-color: rgba(0,0,0,0);color: white; font-size:20px">
                </th>

              <th class="col-md-4">
                <h4 class="card-title">
                    <span>
                      <select v-on:change="getClientId" id="target" ref="client" style="background-color: rgba(0,0,0,0); color: white; boder: none; margin-top: 5%;width: 65%; margin-right: -13px;">
                        <option>Select a Client</option>
                        <option v-for="(client,index) in clients" >
                          <div :data-client-id="client.id">{{ client.name }} </div>
                        </option>
                      </select> 
                      <i class="fa fa-plus"></i>
                    </span>
                </h4>
              </th>

              <th class="col-md-4">
                <h4 class="card-title">
                  <span>
                    <select v-on:change="getProjectId" ref="project" style="background-color: rgba(0,0,0,0); color: white; boder: none; margin-top: 5%;width: 65%; margin-right: -13px;">
                      <option>Select a Project</option>
                      <option v-for="(card,index) in cards" v-if="card.client_id == clientId" ref="project">
                        <p :data="card.id">{{ card.name }} {{ card.client_id }}( {{ card.listing.name}} ) </p>
                      </option>
                    </select>
                    <i @click="editing=true" class="fa fa-plus"></i>
                  </span>
                </h4>
              </th>




              
                <th class="col-md-3">
                  <div class="timepicker" v-if="timepicker==true">
                    <span style="display: inline-flex;">
                      <date-picker v-model="time1" @input="printTime1" style= "margin-left: 10%" placeholder="Start Time" lang="en" type="datetime" format="YYYY-MM-DD hh:mm:ss a" :time-picker-options="{ start: '00:00', step: '00:05', end: '23:55' }"></date-picker>
                      <date-picker v-model="time2" placeholder="End Time" style= "margin-left: 10%" lang="en" type="datetime" format="YYYY-MM-DD hh:mm:ss a" :time-picker-options="{ start: '00:00', step: '00:05', end: '23:55' }"></date-picker>
                    </span>
                  </div>
                  <div class="clocktimer" v-if="clockTimer==true">
                    <span style="display: inline-flex;">
                      <div v-if="showTimer==true" style="margin-top: 7%;">  
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
                        <div style="margin-top: 7%"><h2>{{ minutes }}:{{ seconds }}</h2></div>
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
        value1: '',
        newClientId: '',
        editing: false,
        showStart: true,
        showPause:  false,
        showTimer: false,
        clockTimer: true,
        timepicker: false,
        startTime: '',
        endTime: '',
        clientName: "",
        projectId: "nil",
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
        this.description = event.target.value

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
        window.store.timeCardDates.push(this.formatDate(Date()))
        this.timer = null;
        this.resetButton = true;
        this.saveTimeCard()
        console.log(this.totalTime)
        var description = this.$refs.description.value
        var client = this.$refs.client.value
        var project = this.$refs.project.value
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
