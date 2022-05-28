//
//  YemekSolTableViewCell.swift
//  Capstone
//
//  Created by Irmak Zenger on 5/27/22.
//

import UIKit

class YemekSolTableViewCell: UITableViewCell {

    @IBOutlet weak var solImageView: UIImageView!
    
    @IBOutlet weak var solYemekLabel: UILabel!
    
    
    @IBOutlet weak var solFiyatButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
