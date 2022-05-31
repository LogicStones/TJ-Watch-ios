//
//  SalesmanCell.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 02/02/2022.
//

import UIKit

class SalesmanCell: UITableViewCell {

    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var imgSaleman: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTotalSold: UILabel!
    @IBOutlet weak var lblTotalSale: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.imgSaleman.layer.cornerRadius = self.imgSaleman.frame.width / 2.0
        self.vwContent.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
