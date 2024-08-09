<script setup lang="ts">
import { ref } from 'vue';
import xterm from './xterm.vue';
let statusbarActiveTab = ref<number>(2);
function setActiveTab(tab: number): void {
	// console.log(tab);
	statusbarActiveTab.value = tab;
}
</script>
<template lang="pug">
div(class="relative w-full flex flex-col item-center justify-center bg-[var(--LTheme2)] dark:bg-[var(--Theme2)] text-green-300 ")
	//- The Head of bottom status bar
	ul(class="w-full h-8 flex items-center justify-start p-4")
		li(v-show="false" class="flex items-center h-8 p-3 text-white hover:opacity-100 hover:cursor-pointer border-b-4" :class="statusbarActiveTab === 1 ? 'opacity-100 border-b-[var(--light-fav-color)] dark:border-[var(--dark-fav-color)] border-b-4': 'opacity-50 border-transparent'")
			button(type="button" @click="setActiveTab(1)") Status
		li(class="flex items-center h-8 p-3 text-black dark:text-white hover:opacity-100 rounded-t-lg border-b-4 border-2" :class="statusbarActiveTab === 2 ? 'opacity-100 border-[var(--light-fav-color)] dark:border-[var(--dark-fav-color)] border-b-4': 'opacity-50 border-transparent'")
			button(type="button" class="cursor-default" @click="setActiveTab(2)") Output
		li(v-show="false" class="flex items-center h-8 p-3 text-white hover:opacity-100 hover:cursor-pointer border-b-4" :class="statusbarActiveTab === 3 ? 'opacity-100 border-b-[var(--light-fav-color)] dark:border-[var(--dark-fav-color)] border-b-4': 'opacity-50 border-transparent'")
			button(type="button" @click="setActiveTab(3)") Errors
	div(class="p-3 w-full overflow-hidden bg-[var(--light-fav-color)] dark:bg-[var(--dark-fav-color)]" v-show="true")
		xterm
</template>