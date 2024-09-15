"use strict";
import Gdk from 'gi://Gdk';
import GLib from 'gi://GLib';
import App from 'resource:///com/github/Aylur/ags/app.js';
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js';

import { Bar } from "./modules/bar/bar.js";
import { applauncher } from "./modules/applauncher/applauncher.js";
import { NotificationPopups } from "./modules/notification-popups/notificationPopups.js";

import Dock from './modules/dock/main.js';
import userOptions from "./user_options.js";
// import { COMPILED_STYLE_DIR } from './init.js';

// const range = (length, start = 1) => Array.from({ length }, (_, i) => i + start);
// function forMonitors(widget) {
// 	const n = Gdk.Display.get_default()?.get_n_monitors() || 1;
// 	return range(n, 0).map(widget).flat(1);
// }

// handleStyles(true);
const Windows = () => [
	Bar(),
	applauncher,
	NotificationPopups(),
	Dock,
];
App.config({
	// css: `${COMPILED_STYLE_DIR}/style.css`,
	// style: "./style.css",
	windows: Windows().flat(1),
});
export { };

