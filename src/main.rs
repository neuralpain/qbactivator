use std::io;

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

enum VersionNumber {
  NINETEEN,
  EIGHTEEN,
  TWELVE,
  ELEVEN
}

struct VersionData {
  version_number: VersionNumber,
  executable: String,
  location: String,
  hash: String,
  install_path: String,
}

static QB_VERSION_LIST: [u32; 4] = [19,18,12,11];

fn main() {
  let version_19: VersionData = VersionData {
    version_number: VersionNumber::NINETEEN,
    executable: String::from("QuickBooksPOSV19.exe"),
    location: String::from(r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 19.0"),
    hash: String::from("F5C434677270319F9A515210CA916187"),
    install_path: String::from(r"Intuit\QuickBooks Desktop Point of Sale 19.0"),
  };
  
  let version_18: VersionData = VersionData {
    version_number: VersionNumber::EIGHTEEN,
    executable: String::from("QuickBooksPOSV18.exe"),
    location: String::from(r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 18.0"),
    hash: String::from("DD45AA4EC0DF431243C9836816E2305A"),
    install_path: String::from(r"Intuit\QuickBooks Desktop Point of Sale 18.0"),
  };
  
  let version_12: VersionData = VersionData {
    version_number: VersionNumber::TWELVE,
    executable: String::from("QuickBooksPOSV12.exe"),
    location: String::from(r"C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 12.0"),
    hash: String::from("30FB99C5E98DF6874D438C478314EF9D"),
    install_path: String::from(r"Intuit\QuickBooks Point of Sale 12.0"),
  };

  let version_11: VersionData = VersionData {
    version_number: VersionNumber::ELEVEN,
    executable: String::from("QuickBooksPOSV11.exe"),
    location: String::from(r"C:\Program Files (x86)\Intuit\QuickBooks Point of Sale 11.0"),
    hash: String::from("A1AF552A49ADFF40E6462A968DD552A4"),
    install_path: String::from(r"Intuit\QuickBooks Point of Sale 11.0"),
  };

  // 1. check for quickbooks installer in current location
  // 2. if not found, ask user to download or relocate
  // 3. prepare to download i.e. test internet speed, query size etc.
  // 4. download
  // 5. run qb installer 

  println!("QuickBooks version?");

  let mut ver = String::new();

  io::stdin()
    .read_line(&mut ver)
    .expect("no response");
}
