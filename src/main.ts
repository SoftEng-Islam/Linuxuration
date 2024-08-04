import { createPinia } from "pinia";
import { createApp } from "vue";
import App from "./App.vue";

import "./styles.css";
import 'animate.css';
import 'remixicon/fonts/remixicon.css';

// Minimalistic but perfect custom scrollbar plugin
import PerfectScrollbar from 'vue-perfect-scrollbar';
import './styles/PerfectScrollbar.css';



// Tippy.js is the complete tooltip, popover, dropdown
import VueTippy from 'vue-tippy';
import 'tippy.js/dist/tippy.css'; // optional for styling


// mount App
createApp(App)
.use(createPinia())
.use(VueTippy,  {
	directive: 'tippy', // => v-tippy
	component: 'tippy', // => <tippy/>
	componentSingleton: 'tippy-singleton', // => <tippy-singleton/>,
	defaultProps: {
	  placement: 'auto-end',
	  allowHTML: true,
	}, // => Global default options * see all props
  }).use(PerfectScrollbar, {
	watchOptions: true,
	options: {
		swipeEasing: true,
	},
}).mount("#app");
