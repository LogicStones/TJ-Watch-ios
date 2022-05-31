//
//  MakeCell.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 02/02/2022.
//

import UIKit

class MakeCell: UITableViewCell {

    @IBOutlet var imgBrand: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTotalWatch: UILabel!
    @IBOutlet weak var vwContent: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwContent.vwCornerRadius(radius: 12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
