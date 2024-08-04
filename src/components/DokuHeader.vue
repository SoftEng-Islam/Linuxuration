<script setup lang="ts">
import { appWindow } from '@tauri-apps/api/window'
import { ref } from 'vue';

function minimize(): void {
	appWindow.minimize();
}

async function maximize()  {
	await appWindow.toggleMaximize();
}
function close(): void {
	appWindow.close();
}


let darkModeChecked =  ref<boolean>(true);

function MT_toggleMode() {
	if(darkModeChecked.value === true) {
		// dark
		document.documentElement.classList.add('dark');
		console.log("dark");
	} else {
		// light
		document.documentElement.classList.remove('dark');
		console.log("light");
	}
};

let LiColorActive = ref<number>(1);

let rootElement = document.querySelector(":root") as HTMLElement;
function setColorTheme(color: number): void {
	LiColorActive.value = color;
	switch(color) {
	case 1:
		rootElement.style.setProperty("--dark-fav-color", 'var(--D-gra)');
		rootElement.style.setProperty("--light-fav-color", 'var(--L-gra)');
		// Dark
		rootElement.style.setProperty("--borderFavColor", 'var(--D-gra)');
		rootElement.style.setProperty("--Theme1", 'var(--th_gra1)');
		rootElement.style.setProperty("--Theme2", 'var(--th_gra2)');
		rootElement.style.setProperty("--Theme3", 'var(--th_gra3)');
		rootElement.style.setProperty("--Theme4", 'var(--th_gra4)');
		// Light
		rootElement.style.setProperty("--LborderFavColor", 'var(--L-gra)');
		rootElement.style.setProperty("--LTheme1", 'var(--Lth_gra1)');
		rootElement.style.setProperty("--LTheme2", 'var(--Lth_gra2)');
		rootElement.style.setProperty("--LTheme3", 'var(--Lth_gra3)');
		rootElement.style.setProperty("--LTheme4", 'var(--Lth_gra4)');
		break;
	case 2:
		rootElement.style.setProperty("--dark-fav-color", 'var(--D-pur)');
		rootElement.style.setProperty("--light-fav-color", 'var(--L-pur)');
		// Dark
		rootElement.style.setProperty("--borderFavColor", 'var(--D-pur)');
		rootElement.style.setProperty("--Theme1", 'var(--th_pur1)');
		rootElement.style.setProperty("--Theme2", 'var(--th_pur2)');
		rootElement.style.setProperty("--Theme3", 'var(--th_pur3)');
		rootElement.style.setProperty("--Theme4", 'var(--th_pur4)');
		// Light
		rootElement.style.setProperty("--LborderFavColor", 'var(--L-pur)');
		rootElement.style.setProperty("--LTheme1", 'var(--Lth_pur1)');
		rootElement.style.setProperty("--LTheme2", 'var(--Lth_pur2)');
		rootElement.style.setProperty("--LTheme3", 'var(--Lth_pur3)');
		rootElement.style.setProperty("--LTheme4", 'var(--Lth_pur4)');
		break;
	case 3:
		rootElement.style.setProperty("--dark-fav-color", 'var(--D-pin)');
		rootElement.style.setProperty("--light-fav-color", 'var(--L-pin)');
		// Dark
		rootElement.style.setProperty("--borderFavColor", 'var(--D-pin)');
		rootElement.style.setProperty("--Theme1", 'var(--th_pin1)');
		rootElement.style.setProperty("--Theme2", 'var(--th_pin2)');
		rootElement.style.setProperty("--Theme3", 'var(--th_pin3)');
		rootElement.style.setProperty("--Theme4", 'var(--th_pin4)');
		// Light
		rootElement.style.setProperty("--LborderFavColor", 'var(--L-pin)');
		rootElement.style.setProperty("--LTheme1", 'var(--Lth_pin1)');
		rootElement.style.setProperty("--LTheme2", 'var(--Lth_pin2)');
		rootElement.style.setProperty("--LTheme3", 'var(--Lth_pin3)');
		rootElement.style.setProperty("--LTheme4", 'var(--Lth_pin4)');
		break;
	case 4:
		rootElement.style.setProperty("--dark-fav-color", 'var(--D-blu)');
		rootElement.style.setProperty("--light-fav-color", 'var(--L-blu)');
		// Dark
		rootElement.style.setProperty("--borderFavColor", 'var(--D-blu)');
		rootElement.style.setProperty("--Theme1", 'var(--th_blu1)');
		rootElement.style.setProperty("--Theme2", 'var(--th_blu2)');
		rootElement.style.setProperty("--Theme3", 'var(--th_blu3)');
		rootElement.style.setProperty("--Theme4", 'var(--th_blu4)');
		// Light
		rootElement.style.setProperty("--LborderFavColor", 'var(--L-blu)');
		rootElement.style.setProperty("--LTheme1", 'var(--Lth_blu1)');
		rootElement.style.setProperty("--LTheme2", 'var(--Lth_blu2)');
		rootElement.style.setProperty("--LTheme3", 'var(--Lth_blu3)');
		rootElement.style.setProperty("--LTheme4", 'var(--Lth_blu4)');

		break;
	case 5:
		rootElement.style.setProperty("--dark-fav-color", 'var(--D-gre)');
		rootElement.style.setProperty("--light-fav-color", 'var(--L-gre)');
		// Dark
		rootElement.style.setProperty("--borderFavColor", 'var(--D-gre)');
		rootElement.style.setProperty("--Theme1", 'var(--th_gre1)');
		rootElement.style.setProperty("--Theme2", 'var(--th_gre2)');
		rootElement.style.setProperty("--Theme3", 'var(--th_gre3)');
		rootElement.style.setProperty("--Theme4", 'var(--th_gre4)');
		// Light
		rootElement.style.setProperty("--LborderFavColor", 'var(--L-gre)');
		rootElement.style.setProperty("--LTheme1", 'var(--Lth_gre1)');
		rootElement.style.setProperty("--LTheme2", 'var(--Lth_gre2)');
		rootElement.style.setProperty("--LTheme3", 'var(--Lth_gre3)');
		rootElement.style.setProperty("--LTheme4", 'var(--Lth_gre4)');
		break;
	case 6:
		rootElement.style.setProperty("--dark-fav-color", 'var(--D-yel)');
		rootElement.style.setProperty("--light-fav-color", 'var(--L-yel)');
		// Dark
		rootElement.style.setProperty("--borderFavColor", 'var(--D-yel)');
		rootElement.style.setProperty("--Theme1", 'var(--th_yel1)');
		rootElement.style.setProperty("--Theme2", 'var(--th_yel2)');
		rootElement.style.setProperty("--Theme3", 'var(--th_yel3)');
		rootElement.style.setProperty("--Theme4", 'var(--th_yel4)');
		// Light
		rootElement.style.setProperty("--LborderFavColor", 'var(--L-yel)');
		rootElement.style.setProperty("--LTheme1", 'var(--Lth_yel1)');
		rootElement.style.setProperty("--LTheme2", 'var(--Lth_yel2)');
		rootElement.style.setProperty("--LTheme3", 'var(--Lth_yel3)');
		rootElement.style.setProperty("--LTheme4", 'var(--Lth_yel4)');
	}
}
</script>
<template lang="pug">
//- Our Header
header(class="overflow-hidden w-full top-0 left-0 h-[var(--HeaderHeight)] flex items-center px-4 bg-[var(--LTheme1)] dark:bg-[var(--Theme1)]" data-tauri-drag-region style="user-select: none;")
	//- App Name or The Logo
	h1(class="text-black dark:text-white font-bold mr-auto") Dev-Doku


	//- Settings
	button(type="button", class="w-7 h-7 mx-2 rounded-full flex items-center justify-center bg-[var(--LTheme4)] dark:bg-[var(--Theme4)]")
		<i class="ri-settings-2-line ri-lg text-black dark:text-white animate__animated animate__heartBeat animate__infinite"></i>
	//- Change App Colors and Theme
	div(class="px-2 h-8 overflow-hidden rounded-full flex items-center justify-center gap-2 bg-[var(--Theme3)]")
		button(type="button", @click="setColorTheme(1)" :class="LiColorActive === 1 ? 'scale-125 mx-2': ''" class="w-5 h-5 rounded-full cursor-pointer hover:scale-90 duration-150 bg-[var(--L-gra)]")
		button(type="button", @click="setColorTheme(2)" :class="LiColorActive === 2 ? 'scale-125 mx-2': ''" class="w-5 h-5 rounded-full cursor-pointer hover:scale-90 duration-150 bg-[var(--L-pur)]")
		button(type="button", @click="setColorTheme(3)" :class="LiColorActive === 3 ? 'scale-125 mx-2': ''" class="w-5 h-5 rounded-full cursor-pointer hover:scale-90 duration-150	bg-[var(--L-pin)]")
		button(type="button", @click="setColorTheme(4)" :class="LiColorActive === 4 ? 'scale-125 mx-2': ''" class="w-5 h-5 rounded-full cursor-pointer hover:scale-90 duration-150	bg-[var(--L-blu)]")
		button(type="button", @click="setColorTheme(5)" :class="LiColorActive === 5 ? 'scale-125 mx-2': ''" class="w-5 h-5 rounded-full cursor-pointer hover:scale-90 duration-150	bg-[var(--L-gre)]")
		button(type="button", @click="setColorTheme(6)" :class="LiColorActive === 6 ? 'scale-125 mx-2': ''" class="w-5 h-5 rounded-full cursor-pointer hover:scale-90 duration-150	bg-[var(--L-yel)]")

	//- Dark / Light Button
	div(class="toggleMode h-7 w-16 mx-3 flex flex-row items-center justify-center rounded-full bg-[var(--Theme4)] scale-95" @click="darkModeChecked = !darkModeChecked; MT_toggleMode();")
		input(type="checkbox" :checked="darkModeChecked")
		label(for="darkmode-toggle")
			<i class="sun pl-[3px] ri-sun-fill ri-xl text-white"></i>
			<i class="moon ri-moon-fill pb-[1px] ri-xl text-white"></i>
	//- titlebar buttons
	div(class="flex items-center justify-center gap-2 ml-4")
		button(type="button" @click="minimize" class="w-6 h-6 flex items-center justify-center rounded-md cursor-pointer hover:opacity-50 bg-yellow-500")
			<i class="ri-arrow-down-s-fill ri-xl text-white"></i>
		button(type="button" @click="maximize" class="w-6 h-6 flex items-center justify-center rounded-md cursor-pointer hover:opacity-50 bg-green-500")
			<i class="ri-arrow-up-s-fill ri-xl text-white"></i>
		button(type="button" @click="close" class="w-6 h-6 flex items-center justify-center rounded-md cursor-pointer hover:opacity-50 bg-red-500")
			<i class="ri-close-fill ri-xl text-white"></i>
</template>
<style scoped lang="scss">
.toggleMode {
	input {
		@apply w-0 h-0;
		visibility: hidden;
		&:checked + label {
			@apply bg-[var(--Theme4)];
		}
		&:checked + label:after {
			@apply left-full;
			transform: translateX(-100%);
			background: linear-gradient(180deg,#868686,#8D5EB9);
		}
		&:checked + label i.sun {
			@apply fill-gray-400
		}
		&:checked + label i.moon {
			@apply fill-white;
		}
	}

	label {
		@apply w-full h-full relative flex flex-row items-center justify-center rounded-full cursor-pointer duration-300;
		&:after {
			content: "";
			@apply w-8 h-8 absolute left-0 rounded-full duration-300;
			background: linear-gradient(180deg,#ffcc89,#c3790c);
			box-shadow: 0px 5px 10px rgba(0,0,0,0.2);
		}
		& i {
			@apply absolute w-7 z-10;
		}
		& i.sun {
			@apply left-0 fill-white duration-300;
		}
		& i.moon {
			@apply  right-0 fill-gray-400 duration-300;
		}
		&:active:after{
			@apply w-10;
		}
	}
}
</style>
