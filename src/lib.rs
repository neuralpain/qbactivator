pub enum Version {
    Eleven = 11,
    Twelve = 12,
    Eighteen = 18,
    Nineteen = 19,
}

pub struct PointOfSale {
    pub version_number: Version,
    pub installer_name: String,
    pub pos_shell_location: String,
    pub data_location: String,
    pub hash: String,
}

impl PointOfSale {
    pub fn install_quickbooks(self) {
        todo!()
    }
}
