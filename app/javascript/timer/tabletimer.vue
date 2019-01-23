<template>
<div>
  <div v-for="date in time_cards_dates">
    <table class="table" style="background-color:white;margin-top:40px; background-color:#F9F9F9; border-radius: 15px; font-family: Roboto, Helvetica, sans-serif; margin-left: 20px;">
      <thead>
        <tr>
          <th scope="col" style="font-weight: bold; font-size: 20px; ">{{date}}</th>
        <tr>
          <th scope="col"><strong>Description</strong></th>
          <th scope="col"><strong>Client</strong></th>
          <th scope="col"><strong>Project</strong></th>
          <th scope="col"><strong>Date</strong></th>
          <th scope="col"><strong>Time</strong></th>
        </tr>
      </thead>
        <tbody @click="printItems">
          <tr v-for="(time_card, index) in time_cards" v-if="time_card.created_at.substr(0,10) == date">
            <td scope="row"><input :value="time_card.description" @keyup="printDescription" :data-id="time_card.id" style="background-color:#F9F9F9"></td>
            <td scope="row"><input :value="time_card.client.name ? time_card.client.name :  time_card.client_id"  style="background-color:#F9F9F9"></td>
            <td scope="row"><input :value="time_card.card.name"  style="background-color:#F9F9F9"></td>
            <td scope="row"><input :value="(time_card.created_at).substr(0,10)"  style="background-color:#F9F9F9"></td>
            <td scope="row"><input :value="time_card.total_time"  style="background-color:#F9F9F9"></td>
          </tr>
        </tbody>
    </table>
  </div>  
</div>  
            

</template>

<script>
  export default {

    props: ["original_time_cards"],
    data: function() {
      return {
        time_cards_dates: window.store.timeCardDates,
        time_cards: this.original_time_cards,
        editing: false,
        timer: null,
        totalTime: (0 * 0),
        resetButton: false,
        title: "Countdown to rest time!",
        edit: false
      }
    },  
    methods: {
      printDescription: function(event){
        console.log('/time_cards/'+timeCardId)
        var timeCardId = event.target.attributes[0].value
        var updatedDescription = event.target.value
        var data = new FormData

        data.append("time_card[description]", updatedDescription)
        Rails.ajax({
          url: '/time_cards/'+timeCardId,
          type: "PATCH",
          data: data,
          dataType: "json",
        })
      },
      printClientId: function(event){
        console.log('/time_cards/'+timeCardId)
        var timeCardId = event.target.attributes[0].value
        var updatedDescription = event.target.value
        var data = new FormData

        data.append("time_card[description]", updatedDescription)
        Rails.ajax({
          url: '/time_cards/'+timeCardId,
          type: "PATCH",
          data: data,
          dataType: "json",
        })
      },
      printCardId: function(event){
        console.log('/time_cards/'+timeCardId)
        var timeCardId = event.target.attributes[0].value
        var updatedDescription = event.target.value
        var data = new FormData

        data.append("time_card[description]", updatedDescription)
        Rails.ajax({
          url: '/time_cards/'+timeCardId,
          type: "PATCH",
          data: data,
          dataType: "json",
        })
      },

      printItems: function() {
        console.log(this.original_time_cards)
      },
      startTimer: function() {
        this.timer = setInterval(() => this.countdown(), 1000); //1000ms = 1 second
        this.resetButton = true;
      },
      stopTimer: function() {
        clearInterval(this.timer);
        this.timer = null;
        this.resetButton = true;
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
      timeRecorded: function(seconds){
        var date = new Date(null);
        date.setSeconds(seconds); // specify value for SECONDS here
        console.log(date.toISOString().substr(11, 8))
        return date.toISOString().substr(11, 8);
      },
      padTime: function(time){
        return (time < 10 ? '0' : '') + time;
      },
      countdown: function() {
        this.totalTime++;
      }
    },
    computed: {
      minutes: function(){
        const minutes = Math.floor(this.totalTime / 60);
        return this.padTime(minutes);
      },
      seconds: function() {
        const seconds = this.totalTime - (this.minutes * 60);
        return this.padTime(seconds);
      },
    },
  }


  </script>

  <style>


  </style>