<script setup lang="ts">
// This starter template is using Vue 3 <script setup> SFCs
// Check out https://vuejs.org/api/sfc-script-setup.html#script-setup
import DokuHeader from "./components/DokuHeader.vue";
// import Greet from "./components/Greet.vue";
import DokuList from "./components/DokuList.vue";
import StatusBar from "./components/StatusBar.vue";
</script>

<template lang="pug">
<doku-header/>
div(class="relative left-0 w-full h-[var(--DokuListsHeight)] flex items-end justify-center")
	<doku-list/>
	<status-bar/>
//- <Greet/>
</template>