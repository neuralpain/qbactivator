use std::path::Path;

// const INTUIT_X86_LOCATION: &str = r"C:\Program Files (x86)\Intuit\";
// const POS_SHELL: &str = r"\QBPOSShell.exe";

pub enum Version {
    Eleven,
    Twelve,
    Eighteen,
    Nineteen,
}

pub struct PointOfSale {
    version_number: Version,
    installer_path: &'static str,
    shell_location: &'static str,
    data_location: &'static str,
    license: &'static str,
    hash: &'static str,
}

impl PointOfSale {
    fn install_quickbooks(self) {
        // self.hash_cmp();
        println!("will install");
    }

    fn hash_cmp(self) {
        println!("{}", self.hash);
    }
}

pub const pos_version_19: PointOfSale = PointOfSale {
    version_number: Version::Nineteen,
    installer_path: "QuickBooksPOSV19.exe",
    shell_location: r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 19.0\QBPOSShell.exe",
    data_location: r"C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 19.0",
    license: r#"<Registration InstallDate="" LicenseNumber="0106-3903-4389-908" ProductNumber="595-828"/>"#,
    hash: "F5C434677270319F9A515210CA916187",
};

pub const pos_version_18: PointOfSale = PointOfSale {
    version_number: Version::Eighteen,
    installer_path: "QuickBooksPOSV18.exe",
    shell_location: r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 18.0\QBPOSShell.exe",
    data_location: r"C:\ProgramData\Intuit\QuickBooks Desktop Point of Sale 18.0",
    license: r#"<Registration InstallDate="" LicenseNumber="2421-4122-2213-596" ProductNumber="818-769"/>"#,
    hash: "DD45AA4EC0DF431243C9836816E2305A",
};

pub const pos_version_12: PointOfSale = PointOfSale {
    version_number: Version::Twelve,
    installer_path: "QuickBooksPOSV12.exe",
    shell_location: r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 12.0\QBPOSShell.exe",
    data_location: r"C:\ProgramData\Intuit\QuickBooks Point of Sale 12.0",
    license: r#"<Registration InstallDate="" LicenseNumber="6740-7656-8840-594" ProductNumber="448-229"/>"#,
    hash: "30FB99C5E98DF6874D438C478314EF9D",
};

pub const pos_version_11: PointOfSale = PointOfSale {
    version_number: Version::Eleven,
    installer_path: "QuickBooksPOSV11.exe",
    shell_location: r"C:\Program Files (x86)\Intuit\QuickBooks Desktop Point of Sale 11.0\QBPOSShell.exe",
    data_location: r"C:\ProgramData\Intuit\QuickBooks Point of Sale 11.0",
    license: r#"<Registration InstallDate="" LicenseNumber="1063-0575-1585-222" ProductNumber="023-147"/>"#,
    hash: "A1AF552A49ADFF40E6462A968DD552A4",
};

// let asd = fs::metadata(&pos_version_11.installer_path).expect("does not exist");

// pub fn find_pos_installer() {

//   if fs::metadata(&pos_version_11.installer_path).expect(
//     if fs::metadata(&pos_version_12.installer_path).expect(
//       if fs::metadata(&pos_version_18.installer_path).expect(

//         if fs::metadata(&pos_version_19.installer_path).expect()
//       )

//   ))

//     }
