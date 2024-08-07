// fn main() {
//     println!("Hello, world!");
// }

#![cfg_attr(
    all(not(debug_assertions), target_os = "windows"),
    windows_subsystem = "windows"
)]

use std::process::Command;
use tauri::{generate_handler, Builder, Runtime};

#[tauri::command]
fn run_bash_script(script: String) -> Result<String, String> {
    let output = Command::new("sh")
        .arg("-c")
        .arg(script)
        .output()
        .map_err(|e| e.to_string())?;

    if output.status.success() {
        Ok(String::from_utf8_lossy(&output.stdout).to_string())
    } else {
        Err(String::from_utf8_lossy(&output.stderr).to_string())
    }
}

fn main() {
    Builder::default()
        .invoke_handler(generate_handler![run_bash_script])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
