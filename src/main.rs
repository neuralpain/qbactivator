use qbactivator::*;
use hex_literal::hex;
use sha2::{Digest, Sha256, Sha512};
use std::{fs, hash, io, path::Path};


const CLIENT_MODULE: &str = r"C:\Windows\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5\Intuit.Spc.Map.EntitlementClient.Common.dll";
const PATCHFILE: &str = r".\qbpatch.dat";
const CLIENT_FILE_HOST: &str = r"https://github.com/neuralpain/qbactivator/files/10475450/qb.patch";
const BYTE_TO_MEGABYTE: u32 = 1048576;
const PATCH_HASH: &str = "1A1816C78925E734FCA16974BDBAA4AA";
const QB_SHELL: &str = "QBPOSShell.exe";

// find fix for this error with multiple quotes in string ↓
// const QBREGV11: &str = r"<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="023-147"/>';
// const QBREGV12: &str = r"<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>';
// const QBREGV18: &str = r"<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>';
// const QBREGV19: &str = r"<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>';

static QB_VERSION_LIST: [u32; 4] = [19, 18, 12, 11];

fn main() {
    let pos_version_19: PointOfSale = PointOfSale {
        version_number: Version::Nineteen,
        installer_name: "QuickBooksPOSV19.exe".to_string(),
        pos_shell_location:
            r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 19.0\QBPOSShell.exe"
                .to_string(),
        data_location: r"C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 19.0".to_string(),
        hash: "F5C434677270319F9A515210CA916187".to_string(),
    };

    let pos_version_18: PointOfSale = PointOfSale {
        version_number: Version::Eighteen,
        installer_name: "QuickBooksPOSV18.exe".to_string(),
        pos_shell_location:
            r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 18.0\QBPOSShell.exe"
                .to_string(),
        data_location: r"C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 18.0".to_string(),
        hash: "DD45AA4EC0DF431243C9836816E2305A".to_string(),
    };

    let pos_version_12: PointOfSale = PointOfSale {
        version_number: Version::Twelve,
        installer_name: "QuickBooksPOSV12.exe".to_string(),
        pos_shell_location:
            r"C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 12.0\QBPOSShell.exe"
                .to_string(),
        data_location: r"C:\ProgramData\Intuit\QuickBooks Point of Sale 12.0".to_string(),
        hash: "30FB99C5E98DF6874D438C478314EF9D".to_string(),
    };

    let pos_version_11: PointOfSale = PointOfSale {
        version_number: Version::Eleven,
        installer_name: "QuickBooksPOSV11.exe".to_string(),
        pos_shell_location:
            r"C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 11.0\QBPOSShell.exe"
                .to_string(),
        data_location: r"C:\ProgramData\Intuit\QuickBooks Point of Sale 11.0".to_string(),
        hash: "A1AF552A49ADFF40E6462A968DD552A4".to_string(),
    };

    // 1. check for quickbooks installer in current pos_shell_location
    // 2. if not found, ask user to download or relocate
    // 3. prepare to download i.e. test internet speed, query size etc.
    // 4. download
    // 5. run qb installer

    if Path::new(&pos_version_11.installer_name).exists() {
        pos_version_11.install_quickbooks();
    } else if Path::new(&pos_version_12.installer_name).exists() {
        pos_version_12.install_quickbooks();
    } else if Path::new(&pos_version_18.installer_name).exists() {
        pos_version_18.install_quickbooks();
    } else if Path::new(&pos_version_19.installer_name).exists() {
        pos_version_19.install_quickbooks();
    };

    println!("does not activate");

    // let mut ver = String::new();

    // io::stdin()
    //   .read_line(&mut ver)
    //   .expect("no response");
}
