pub enum Version {
    Eleven = 11,
    Twelve = 12,
    Eighteen = 18,
    Nineteen = 19,
}

pub struct PointOfSale {
    pub version_number: Version,
    pub installer_path: &'static str,
    pub shell_location: &'static str,
    pub data_location: &'static str,
    pub license: &'static str,
    pub hash: &'static str,
}

impl PointOfSale {
    pub fn install_quickbooks(self) {
        // self.hash_cmp();
        println!("will install");
    }

    fn hash_cmp(self) {
        println!("{}", self.hash);
    }
}

// let asd = fs::metadata(&pos_version_11.installer_path).expect("does not exist");

// pub fn find_pos_installer() {

//   if fs::metadata(&pos_version_11.installer_path).expect(
//     if fs::metadata(&pos_version_12.installer_path).expect(
//       if fs::metadata(&pos_version_18.installer_path).expect(

//         if fs::metadata(&pos_version_19.installer_path).expect()
//       )

//   ))

//     }
