<!-- Terminal.vue -->
<template>
	<div ref="terminal"></div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { Terminal } from '@xterm/xterm';
import '@xterm/xterm/css/xterm.css';
import { invoke } from '@tauri-apps/api/tauri';

const terminalRef = ref(null);
let terminal;

const runScript = async (script) => {
	try {
		const output = await invoke('run_bash_script', { script });
		terminal.write(output);
	} catch (error) {
		terminal.write(`Error: ${error}`);
	}
};

onMounted(() => {
	terminal = new Terminal();
	terminal.open(terminalRef.value);

	// Example script to run
	runScript('echo "Hello, Tauri!"');
});
</script>

<style>
/* Add any additional styles here */
</style>
