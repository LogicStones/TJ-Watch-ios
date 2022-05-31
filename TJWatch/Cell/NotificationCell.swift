//
//  NotificationCell.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 04/02/2022.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet weak var vwContant: UIView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnViewReport: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var constrainBottomMessage: NSLayoutConstraint!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.btnViewReport.vwCornerRadius(radius: 16)
        self.vwContant.vwBorderRadius(color: Constants.appColors.txtBrdClr, bordrWidth: 1, radius: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
