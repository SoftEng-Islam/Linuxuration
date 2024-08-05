<script setup lang="ts">
import { ref } from 'vue';
import DokuPages from "./DokuPages.vue";

import { useTippy } from 'vue-tippy';
const btn = ref();

useTippy(btn, {
	content: 'Active Now!',
	trigger: 'click',

});


// Our List
let activeIndex = ref<null | number>(null);
const items = ref(['Islam', 'Ahmed', 'Mohamed']);


let ri_arrow_left = ref<boolean>(true);
let ri_arrow_right = ref<boolean>(false);
let DokuListClosed = ref<boolean>(false);
function close(): void {
	DokuListClosed.value = !DokuListClosed.value;
	ri_arrow_left.value = !ri_arrow_left.value;
	ri_arrow_right.value = !ri_arrow_right.value;
}
</script>
<template lang="pug">
//- All Docs List
div(class="absolute duration-100 h-[var(--DokuListsHeight)] bg-[var(--LTheme3)] dark:bg-[var(--Theme3)]" :style="DokuListClosed ? 'left: -13rem' : 'left: 0'")
	div(class="h-full w-52 p-4 z-10")
		div()
			input(type="text", placeholder="Search..." value="" , class="w-full h-8 px-2 rounded-md bg-[var(--LTheme1)] dark:bg-[var(--Theme1)] text-black dark:text-white placeholder:text-black dark:placeholder:text-white" )
		div(class="")
			ul(class="DokuList_Ul w-full flex p-5 flex-col justify-center gap-y-4")
				li(v-for="(item, index) in items" :key="index" :class="{ 'active': index === activeIndex }" @click="activeIndex = index")
					button(class="pop-btn" ref="btn")
					| {{ item }}
		button(type="button" @click="close" class="w-4 h-11 rounded-tr-lg rounded-br-lg bg-[var(--LTheme3)] dark:bg-[var(--Theme3)] absolute z-20 top-1/2 right-[-1rem] translate-y-[-50%]")
			<i v-show="ri_arrow_left" class="ri-arrow-left-s-line dark:text-white"></i>
			<i v-show="ri_arrow_right" class="ri-arrow-right-s-line dark:text-white"></i>
	<doku-pages/>
</template>
<style scoped lang="sass">
.DokuList_Ul
	& > li
		@apply text-black dark:text-white flex items-center relative w-full h-7 rounded-md bg-[var(--LTheme1)] dark:bg-[var(--Theme1)] cursor-pointer
		& .pop-btn
			@apply relative block mr-3 h-7 w-3 rounded-md bg-[var(--LTheme2)] dark:bg-[var(--Theme4)]
		&.active
			@apply bg-[var(--light-fav-color)] dark:bg-[var(--dark-fav-color)] font-bold
			& .pop-btn
				@apply bg-black dark:bg-white

.popper
	@apply text-base
</style>