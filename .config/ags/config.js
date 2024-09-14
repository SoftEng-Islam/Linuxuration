import { Bar } from "./simple-bar/bar.js";
import { applauncher } from "./applauncher/applauncher.js";
import { NotificationPopups } from "./notification-popups/notificationPopups.js";
App.config({
	style: "./style.css",
	windows: [
		// @ts-ignore
		Bar(),
		// @ts-ignore
		NotificationPopups(),
		applauncher,
	],
});
export { };

