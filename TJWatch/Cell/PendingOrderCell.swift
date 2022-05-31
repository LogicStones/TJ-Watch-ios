//
//  PendingOrderCell.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 24/01/2022.
//

import UIKit

class PendingOrderCell: UITableViewCell {

    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMake: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblAdvPrice: UILabel!
    @IBOutlet weak var lblBalance: UILabel!
    @IBOutlet weak var btnSell: UIButton!
    @IBOutlet weak var btnAddWatch: UIButton!
    @IBOutlet var lblDail: UILabel!
    @IBOutlet var btnDel: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwContent.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
        self.btnSell.vwCornerRadius(radius: 12)
        self.btnAddWatch.vwCornerRadius(radius: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
