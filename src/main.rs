use std::process::Command;
use tauri::command;

#[command]
fn run_bash_script(script: String) -> Result<String, String> {
    let output = Command::new("bash")
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
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![run_bash_script])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
