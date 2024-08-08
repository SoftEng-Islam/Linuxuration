import { createPinia } from "pinia";
import { createApp } from "vue";
import App from "./App.vue";

import "./styles.css";
import "animate.css";
import "remixicon/fonts/remixicon.css";

// Minimalistic but perfect custom scrollbar plugin
// import { PerfectScrollbar } from "vue3-perfect-scrollbar";
// import "./styles/PerfectScrollbar.css";

// mount App
createApp(App).use(createPinia()).mount("#app");
