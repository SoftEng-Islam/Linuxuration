<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { Terminal } from '@xterm/xterm';
import '@xterm/xterm/css/xterm.css';
import { invoke } from '@tauri-apps/api/tauri';

// Create a reference for the terminal container
const terminalRef = ref<HTMLElement | null>(null);
const terminal = ref<Terminal | null>(null);

const runScript = async (script: string) => {
	try {
		// Invoke the Tauri command and get the output
		const output: string | Uint8Array = await invoke('run_bash_script', { script });

		// Write the output to the terminal
		terminal.value?.write(typeof output === 'string' ? output : new TextDecoder().decode(output));
	} catch (error) {
		// Write the error message to the terminal
		terminal.value?.write(`Error: ${error}`);
	}
};

onMounted(() => {
	// Initialize the terminal instance
	terminal.value = new Terminal();

	// Ensure the terminalRef is not null before opening the terminal
	if (terminalRef.value) {
		terminal.value.open(terminalRef.value);

		// Example script to run
		runScript('echo "Hello, world"');
	}
});
</script>

<template lang="pug">
div(ref="terminalRef" class="h-16 mb-2 overflow-hidden")
</template>