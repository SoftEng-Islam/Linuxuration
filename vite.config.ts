import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import pugPlugin from "vite-plugin-pug";

// https://vitejs.dev/config/
export default defineConfig({
	plugins: [pugPlugin(), vue()],
	optimizeDeps: {
		include: ["@xterm/xterm"],
	},
	clearScreen: false,
	server: {
		port: 1420,
		strictPort: false,
	},
	envPrefix: ["VITE_", "TAURI_"],
});
