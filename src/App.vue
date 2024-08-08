<script setup lang="ts">
import DokuHeader from "./components/DokuHeader.vue";
import DokuList from "./components/DokuList.vue";
import StatusBar from "./components/StatusBar.vue";
// import Greet from "./components/Greet.vue";
</script>

<template lang="pug">
<DokuHeader/>
div(class="relative left-0 w-full h-[var(--DokuListsHeight)] flex items-end justify-center")
	<DokuList/>
	<StatusBar/>
//- <Greet/>
</template>
