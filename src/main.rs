use hex_literal::hex;
use qbactivator::*;
use sha2::{Digest, Sha256, Sha512};
use std::fs;
use std::hash;
use std::io;
use std::os;
use std::path::Path;
use std::path::PathBuf;

fn main() {
    const CLIENT_MODULE: &'static str = r"C:\Windows\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5\Intuit.Spc.Map.EntitlementClient.Common.dll";
    const PATCHFILE: &'static str = r".\qbpatch.dat";
    const CLIENT_FILE_HOST: &'static str =
        "https://github.com/neuralpain/qbactivator/files/10475450/qb.patch";
    const BYTE_TO_MEGABYTE: u32 = 1048576;
    const PATCH_HASH: &'static str = "1A1816C78925E734FCA16974BDBAA4AA";
    // const QB_SHELL: &'static str = "QBPOSShell.exe";

    let QB_VERSION_LIST: [u32; 4] = [19, 18, 12, 11];

    // 1. check for quickbooks installer in current shell_location
    // 2. if not found, ask user to download or relocate
    // 3. prepare to download i.e. test internet speed, query size etc.
    // 4. download
    // 5. run qb installer

    // let x: Result<bool, bool> = Ok(fs::metadata(&pos_version_11.installer_path)).is_ok()

    // println!("{}", current_dir());

    // let current_dir = "."; // Current directory

    // let exe_files = collect_exe_files();
    // let quickbooks_pos_file = find_quickbooks_pos(&exe_files);
    //
    // match quickbooks_pos_file {
    //     Some(file) => println!("Found QuickBooksPOS: {:?}", file),
    //     None => println!("QuickBooksPOS not found."),
    // }

    // match fs::metadata(&pos_version_11.installer_path) {
    // Ok(_) => println!("will  install {}", pos_version_11.installer_path.display()),
    // Err(_) => println!("will not install {}", pos_version_11.installer_path.display()),
    // };

    // if Ok(fs::metadata(&pos_version_11.installer_path)).is_ok() {
    // pos_version_11.install_quickbooks();
    // } else if (Ok(fs::metadata(&pos_version_12.installer_path))).is_ok() {
    // pos_version_12.install_quickbooks();
    // } else if (Ok(fs::metadata(&pos_version_18.installer_path))).is_ok() {
    // pos_version_18.install_quickbooks();
    // } else if (Ok(fs::metadata(&pos_version_19.installer_path))).is_ok() {
    // pos_version_19.install_quickbooks();
    // } else {
    // println!("does not activate");
    // }

    // let mut ver = String::new();

    // io::stdin()
    //   .read_line(&mut ver)
    //   .expect("no response");
}

// fn collect_exe_files() -> Vec<PathBuf> {
//     let current_dir = std::env::current_dir().expect("Failed to get the current directory.");

//     let mut exe_files = Vec::new();

//     if let Ok(entries) = fs::read_dir(current_dir) {
//         for entry in entries {
//             if let Ok(entry) = entry {
//                 let file_name = entry.file_name().to_string_lossy().to_string();
//                 if file_name.ends_with(".exe") {
//                     exe_files.push(entry.path());
//                 }
//             }
//         }
//     }

//     exe_files
// }

// fn find_quickbooks_pos(exe_files: &[PathBuf]) -> Option<&PathBuf> {
//     let quickbooks_pos_versions = [
//         &pos_version_11.installer_path,
//         &pos_version_12.installer_path,
//         &pos_version_18.installer_path,
//         &pos_version_19.installer_path,
//     ];

//     for version in &quickbooks_pos_versions {
//         for file in exe_files {
//             if let Some(file_name) = file.file_name() {
//                 if file_name == *version {
//                     return Some(file);
//                 }
//             }
//         }
//     }

//     None
// }
