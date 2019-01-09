<template>
  <div :class="sidebarClasses" :data-background-color="backgroundColor" :data-active-color="activeColor">
    <!--
            Tip 1: you can change the color of the sidebar's background using: data-background-color="white | black | darkblue"
            Tip 2: you can change the color of the active button using the data-active-color="primary | info | success | warning | danger"
        -->
    <!-- -->
    <div class="sidebar-wrapper" id="style-3">
      <div class="logo">
        <a href="#" class="simple-text">
            <div class="logo-img">
                <img src="" alt="">
            </div>
          Paper Dashboard
        </a>
      </div>
      <slot>

      </slot>
      <ul :class="navClasses">
        <li class="nav-item ">
            <a class="nav-link" href="http://localhost:3000/clients">
                <span class="sidebar-mini"><strong>C</strong></span>
                <span class="sidebar-normal">Clients</span>
            </a>
        </li>
        <li class="nav-item ">
            <a class="nav-link" href="http://localhost:3000/listings">
                <span class="sidebar-mini"><strong>L</strong></span>
                <span class="sidebar-normal">Lists</span>
            </a>
        </li>
        <li class="nav-item ">
            <a class="nav-link" href="http://localhost:3000/Timer">
                <span class="sidebar-mini"><strong>T</strong></span>
                <span class="sidebar-normal">Timer</span>
            </a>
        </li>
      </ul>
      <movingarrow :move-y="arrowMovePx">

      </movingarrow>
    </div>
  </div>
</template>
<script>
  import movingarrow from './movingarrow.vue'
  export default {
    props: {
      type: {
        type: String,
        default: 'sidebar',
        validator: (value) => {
          let acceptedValues = ['sidebar', 'navbar']
          return acceptedValues.indexOf(value) !== -1
        }
      },
      backgroundColor: {
        type: String,
        default: 'white',
        validator: (value) => {
          let acceptedValues = ['white', 'black', 'darkblue']
          return acceptedValues.indexOf(value) !== -1
        }
      },
      activeColor: {
        type: String,
        default: 'success',
        validator: (value) => {
          let acceptedValues = ['primary', 'info', 'success', 'warning', 'danger']
          return acceptedValues.indexOf(value) !== -1
        }
      },
      sidebarLinks: {
        type: Array,
        default: () => ["Timer", "Lists", "Clients"]
      }
    },
    components: {
      movingarrow
    },
    computed: {
      sidebarClasses () {
        if (this.type === 'sidebar') {
          return 'sidebar'
        } else {
          return 'collapse navbar-collapse off-canvas-sidebar'
        }
      },
      navClasses () {
        if (this.type === 'sidebar') {
          return 'nav'
        } else {
          return 'nav navbar-nav'
        }
      },
      /**
       * Styles to animate the arrow near the current active sidebar link
       * @returns {{transform: string}}
       */
      arrowMovePx () {
        return this.linkHeight * this.activeLinkIndex
      }
    },
    data () {
      return {
        linkHeight: 60,
        activeLinkIndex: 0,

        windowWidth: 0,
        isWindows: false,
        hasAutoHeight: false
      }
    },
    methods: {
      findActiveLink () {
        this.sidebarLinks.find((element, index) => {
          let found = element.path === this.$route.path
          if (found) {
            this.activeLinkIndex = index
          }
          return found
        })
      }
    },
    mounted () {
      this.findActiveLink()
    },
    watch: {
      $route: function (newRoute, oldRoute) {
        this.findActiveLink()
      }
    }
  }

</script>
<style>

</style>
