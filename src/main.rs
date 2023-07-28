use hex_literal::hex;
use qbactivator::*;
use sha2::{Digest, Sha256, Sha512};
use std::{fs, hash, io, os, path::Path};

fn main() {
    const CLIENT_MODULE: &'static str = r"C:\Windows\Microsoft.NET\assembly\GAC_MSIL\Intuit.Spc.Map.EntitlementClient.Common\v4.0_8.0.0.0__5dc4fe72edbcacf5\Intuit.Spc.Map.EntitlementClient.Common.dll";
    const PATCHFILE: &'static str = r".\qbpatch.dat";
    const CLIENT_FILE_HOST: &'static str =
        "https://github.com/neuralpain/qbactivator/files/10475450/qb.patch";
    const BYTE_TO_MEGABYTE: u32 = 1048576;
    const PATCH_HASH: &'static str = "1A1816C78925E734FCA16974BDBAA4AA";
    // const QB_SHELL: &'static str = "QBPOSShell.exe";

    let QB_VERSION_LIST: [u32; 4] = [19, 18, 12, 11];

    let pos_version_19: PointOfSale = PointOfSale {
        version_number: Version::Nineteen,
        installer_path: r"/QuickBooksPOSV19.exe",
        shell_location: r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 19.0\QBPOSShell.exe",
        data_location: r"C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 19.0",
        license: r#"<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>"#,
        hash: "F5C434677270319F9A515210CA916187",
    };

    let pos_version_18: PointOfSale = PointOfSale {
        version_number: Version::Eighteen,
        installer_path: r"/QuickBooksPOSV18.exe",
        shell_location: r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 18.0\QBPOSShell.exe",
        data_location: r"C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 18.0",
        license: r#"<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>"#,
        hash: "DD45AA4EC0DF431243C9836816E2305A",
    };

    let pos_version_12: PointOfSale = PointOfSale {
        version_number: Version::Twelve,
        installer_path: r"/QuickBooksPOSV12.exe",
        shell_location: r"C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 12.0\QBPOSShell.exe",
        data_location: r"C:\ProgramData\Intuit\QuickBooks Point of Sale 12.0",
        license: r#"<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>"#,
        hash: "30FB99C5E98DF6874D438C478314EF9D",
    };

    let pos_version_11: PointOfSale = PointOfSale {
        version_number: Version::Eleven,
        installer_path: r"/QuickBooksPOSV11.exe",
        shell_location: r"C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 11.0\QBPOSShell.exe",
        data_location: r"C:\ProgramData\Intuit\QuickBooks Point of Sale 11.0",
        license: r#"<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="023-147"/>"#,
        hash: "A1AF552A49ADFF40E6462A968DD552A4",
    };

    // 1. check for quickbooks installer in current shell_location
    // 2. if not found, ask user to download or relocate
    // 3. prepare to download i.e. test internet speed, query size etc.
    // 4. download
    // 5. run qb installer

    if Path::new(&pos_version_11.installer_path).exists() {
        pos_version_11.install_quickbooks();
    } else if Path::new(&pos_version_12.installer_path).exists() {
        pos_version_12.install_quickbooks();
    } else if Path::new(&pos_version_18.installer_path).exists() {
        pos_version_18.install_quickbooks();
    } else if Path::new(&pos_version_19.installer_path).exists() {
        pos_version_19.install_quickbooks();
    } else { println!("does not activate"); }

    // let mut ver = String::new();

    // io::stdin()
    //   .read_line(&mut ver)
    //   .expect("no response");
}
