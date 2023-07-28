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
        self.hash_cmp()
    }

    fn hash_cmp(self) {
        println!("{}", self.hash);
    }
}
