
<template> 

<div class="drop-down">
    <div class="selected" style="padding-right: 10px;">
    <a @click="" style="text-align:center;width: 250px;border-radius: 5px;text-decoration: none;color:black;font-family:arial;padding-top:7px;padding-left:1%;display: block;padding-right:20px;height: 50px; background-color:white;"><span @click="showList = !showList">{{dropdownValue}}</span><i class="fa fa-caret-down pull-right" style="margin-top: 5px;"></i></a>
    </div>
    <div v-if="showList == true" class="options" style="position:relative;">
    <ul style="z-index: 10000;background:#fff none repeat scroll 0 0;list-style:none;  padding:0px 0px;position:absolute; left:0px; top:0px; width:auto; min-width:170px;border:1px solid #d7d7d7;">
        <li><a @click="showList = !showList" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;">Select a client</a></li>
        <li v-for="client in clients"><a @click="" style="text-align:center;z-index=1000;width: 250px;padding: 5px;display: block;text-decoration: none;color: gray;padding-left: 0%;font-family: arial;height: 40px;padding-top: 10px;" :data-id="client.id">{{client.name}}</a></li>
    </ul>
    </div>
</div>

</template>

<script>

export default {

    props: ["client_list"],
    components: { DatePicker },
    data: function() {
      return {
        clients: this.client_list

        }
    }
}


</script>
