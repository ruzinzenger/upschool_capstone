//
//  SepetTableViewCell.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/28/22.
//

import UIKit

class SepetTableViewCell: UITableViewCell {
    @IBOutlet weak var sepetImageView: UIImageView!
    
    
    @IBOutlet weak var sepetYemekLabel: UILabel!
    
    
    @IBOutlet weak var sepetAdetLabel: UILabel!
    
    
    @IBOutlet weak var sepetAraToplamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
