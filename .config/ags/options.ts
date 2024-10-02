import { opt, mkOptions } from "lib/option";
import { distro } from "lib/variables";
import { icon } from "lib/utils";
import icons from "lib/icons";

const options = mkOptions(OPTIONS, {
	autotheme: opt(false),

	wallpaper: {
		resolution: opt<import("service/wallpaper").Resolution>(1920),
		market: opt<import("service/wallpaper").Market>("random"),
	},

	theme: {
		dark: {
			primary: {
				bg: opt("#7C51E7"),
				fg: opt("#141414"),
			},
			error: {
				bg: opt("#E55F5F"),
				fg: opt("#141414"),
			},
			bg: opt("#171717"),
			fg: opt("#eeeeee"),
			widget: opt("#eeeeee"),
			border: opt("#eeeeee"),
		},
		light: {
			primary: {
				bg: opt("#9542DE"),
				fg: opt("#eeeeee"),
			},
			error: {
				bg: opt("#b13558"),
				fg: opt("#eeeeee"),
			},
			bg: opt("#fffffa"),
			fg: opt("#080808"),
			widget: opt("#080808"),
			border: opt("#080808"),
		},
		blur: opt(15),
		scheme: opt<"dark" | "light">("dark"),
		widget: { opacity: opt(80) },
		border: {
			width: opt(2),
			opacity: opt(100),
		},
		shadows: opt(true),
		padding: opt(5),
		spacing: opt(9),
		radius: opt(10),
	},

	transition: opt(200),

	font: {
		size: opt(13),
		name: opt("JetBrains Mono"),
	},

	bar: {
		flatButtons: opt(false),
		position: opt<"top" | "bottom">("top"),
		corners: opt(50),
		transparent: opt(false),
		layout: {
			start: opt<Array<import("widget/bar/Bar").BarWidget>>([
				"launcher",
				"workspaces",
				"expander",
				"messages",
			]),
			center: opt<Array<import("widget/bar/Bar").BarWidget>>(["date"]),
			end: opt<Array<import("widget/bar/Bar").BarWidget>>([
				"expander",
				"taskbar",
				"media",
				"systray",
				"colorpicker",
				"screenrecord",
				"system",
				"battery",
				"powermenu",
			]),
		},
		launcher: {
			icon: {
				colored: opt(true),
				icon: opt(icon(distro.logo, icons.ui.search)),
			},
			label: {
				colored: opt(false),
				label: opt(" Apps "),
			},
			action: opt(() => App.toggleWindow("launcher")),
		},
		date: {
			format: opt("%H:%M - %A %e."),
			action: opt(() => App.toggleWindow("datemenu")),
		},
		battery: {
			bar: opt<"hidden" | "regular" | "whole">("regular"),
			charging: opt("#00D787"),
			percentage: opt(true),
			blocks: opt(7),
			width: opt(50),
			low: opt(30),
		},
		workspaces: {
			workspaces: opt(9),
		},
		taskbar: {
			iconSize: opt(0),
			monochrome: opt(false),
			exclusive: opt(false),
		},
		messages: {
			action: opt(() => App.toggleWindow("datemenu")),
		},
		systray: {
			ignore: opt(["KDE Connect Indicator", "spotify-client"]),
		},
		media: {
			monochrome: opt(false),
			preferred: opt("spotify"),
			direction: opt<"left" | "right">("right"),
			format: opt("{artists} - {title}"),
			length: opt(40),
		},
		powermenu: {
			monochrome: opt(false),
			action: opt(() => App.toggleWindow("powermenu")),
		},
	},

	launcher: {
		width: opt(0),
		margin: opt(80),
		nix: {
			pkgs: opt("nixpkgs/nixos-unstable"),
			max: opt(8),
		},
		sh: {
			max: opt(16),
		},
		apps: {
			iconSize: opt(62),
			max: opt(6),
			favorites: opt([
				[
					"google-chrome",
					"microsoft-edge",
					"org.gnome.Nautilus",
					"obsidian",
					"0ad",
				],
			]),
		},
	},

	overview: {
		scale: opt(9),
		workspaces: opt(7),
		monochromeIcon: opt(false),
	},

	powermenu: {
		sleep: opt("systemctl suspend"),
		reboot: opt("systemctl reboot"),
		logout: opt("pkill Hyprland"),
		shutdown: opt("shutdown now"),
		layout: opt<"line" | "box">("line"),
		labels: opt(true),
	},

	quicksettings: {
		avatar: {
			image: opt(`/var/lib/AccountsService/icons/${Utils.USER}`),
			size: opt(70),
		},
		width: opt(380),
		position: opt<"left" | "center" | "right">("right"),
		networkSettings: opt("gtk-launch gnome-control-center"),
		media: {
			monochromeIcon: opt(false),
			coverSize: opt(100),
		},
	},

	datemenu: {
		position: opt<"left" | "center" | "right">("center"),
		weather: {
			interval: opt(60_000),
			unit: opt<"metric" | "imperial" | "standard">("metric"),
			key: opt<string>(
				JSON.parse(Utils.readFile(`${App.configDir}/.weather`) || "{}")
					?.key || ""
			),
			cities: opt<Array<number>>(
				JSON.parse(Utils.readFile(`${App.configDir}/.weather`) || "{}")
					?.cities || []
			),
		},
	},

	osd: {
		progress: {
			vertical: opt(true),
			pack: {
				h: opt<"start" | "center" | "end">("end"),
				v: opt<"start" | "center" | "end">("center"),
			},
		},
		microphone: {
			pack: {
				h: opt<"start" | "center" | "end">("center"),
				v: opt<"start" | "center" | "end">("end"),
			},
		},
	},

	notifications: {
		position: opt<Array<"top" | "bottom" | "left" | "right">>([
			"top",
			"right",
		]),
		blacklist: opt(["Spotify"]),
		width: opt(440),
	},

	hyprland: {
		gaps: opt(2.4),
		inactiveBorder: opt("#282828"),
		gapsWhenOnly: opt(false),
	},
});

globalThis["options"] = options;
export default options;
