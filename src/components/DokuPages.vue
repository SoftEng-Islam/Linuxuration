<script setup lang="ts">
</script>
<template lang="pug">
//- pages for selected Doc
div(class="shadow-xl absolute w-52 left-52 p-4 h-full top-0 bg-[var(--LTheme1)] dark:bg-[var(--Theme1)]")
	div()
		input(type="text", placeholder="Search..." value="" , class="w-full h-8 px-2 rounded-md bg-[var(--LTheme3)] dark:bg-[var(--Theme3)] text-black dark:text-white placeholder:text-black placeholder:dark:text-white" )
	div(class="")
		ul(class="w-full flex p-5 flex-col justify-center gap-y-4")
			li(class="relative w-full h-7 rounded-md bg-[var(--LTheme3)] dark:bg-[var(--Theme3)] cursor-pointer ")
			li(class="relative w-full h-7 rounded-md bg-[var(--LTheme3)] dark:bg-[var(--Theme3)] cursor-pointer ")
	//- button(type="button" id="closeOrResize" class="w-4 h-11 rounded-tr-lg rounded-br-lg bg-[var(--cD1)] absolute top-1/2 right-[-1rem] translate-y-[-50%]")
</template>