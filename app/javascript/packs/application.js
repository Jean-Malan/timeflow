import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'
import Timer from '../timer/timer.vue'
import TimerTable from '../timer/tabletimer.vue'
import Card from '../components/card.vue'
import Todotable from "../todo/todotable.vue"
import Tagindex from "../tags/tagindex.vue"


window.store = {}

document.addEventListener('DOMContentLoaded', () => {
  var element = document.querySelector('#boards')
  if(element != undefined) {
    console.group(element.dataset.timeCards)
    window.store.lists = JSON.parse(element.dataset.lists)
    window.store.client = JSON.parse(element.dataset.client)
    window.store.timeCards = JSON.parse(element.dataset.timeCards)
    window.store.cards = JSON.parse(element.dataset.timeCards)
    window.store.tags = JSON.parse(element.dataset.tags)
    console.log(window.store.timeCards)

    const app = new Vue({
      el: element,
      data: window.store,
      template: "<App :original_lists='lists' :original_time_cards='time_cards' :tag_list='tags' />",
      components: { App, Card }
    })
  }
})

document.addEventListener('DOMContentLoaded', () => {
  var element = document.querySelector('#timer')
  if(element != undefined) {
    window.store.timecards = JSON.parse(element.dataset.timecards)
    window.store.clients = JSON.parse(element.dataset.clients)
    window.store.cards = JSON.parse(element.dataset.cards)

    console.log(JSON.parse(element.dataset.clients))
    const app = new Vue({
      el: element,
      data:  window.store,
      dataType: 'json',
      template: "<Timer :client_list='clients' :card_list='cards' :original_time_cards='timecards'/>",
      components: { Timer }
    })
  }
})

document.addEventListener('DOMContentLoaded', () => {
  var element = document.querySelector('#timertable')
  if(element != undefined) {
    console.log(element.dataset.timecards)
    window.store.timecards = JSON.parse(element.dataset.timecards)

    const app = new Vue({
      el: element,
      data:  window.store,
      dataType: 'json',
      template: "<TimerTable :original_time_cards='timecards'/>",
      components: { TimerTable }
    })
  }
})

document.addEventListener('DOMContentLoaded', () => {
  var element = document.querySelector('#todo')
  if(element != undefined) {
    window.store.cards = JSON.parse(element.dataset.cards)

    const app = new Vue({
      el: element,
      data:  window.store,
      dataType: 'json',
      template: "<Todotable :cards='cards'/>",
      components: { Todotable }
    })
  }
})

document.addEventListener('DOMContentLoaded', () => {
  var element = document.querySelector('#tagIndex')
  if(element != undefined) {
    window.store.tags = JSON.parse(element.dataset.tags)

    const app = new Vue({
      el: element,
      data:  window.store,
      dataType: 'json',
      template: "<Tagindex :tags='tags'/>",
      components: { Tagindex }
    })
  }
})
