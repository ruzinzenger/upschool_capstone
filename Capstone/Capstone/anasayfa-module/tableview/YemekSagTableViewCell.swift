//
//  YemekSagTableViewCell.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/27/22.
//

import UIKit

class YemekSagTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var sagImageView: UIImageView!
    
    
    @IBOutlet weak var sagYemekLabel: UILabel!
    
    
    @IBOutlet weak var sagFiyatButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
