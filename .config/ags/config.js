import { Bar } from "./modules/simple-bar/bar.js";
import { applauncher } from "./modules/applauncher/applauncher.js";
import { NotificationPopups } from "./modules/notification-popups/notificationPopups.js";
App.config({
	style: "./style.css",
	windows: [
		Bar(),
		NotificationPopups(),
		applauncher,
	],
});
export { };

