//
//  ServiceListCell.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 30/12/2021.
//

import UIKit

class ServiceListCell: UITableViewCell {

    @IBOutlet weak var imgWatch: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSerialNo: UILabel!
    @IBOutlet weak var lblCustomerName: UILabel!
    @IBOutlet weak var lblTypeOfProblem: UILabel!
    @IBOutlet weak var lblReturnDate: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblRemainingPrice: UILabel!
    @IBOutlet weak var lblAdvance: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblStatusReslt: UILabel!
    @IBOutlet weak var btnMarkComplete: UIButton!
    @IBOutlet var lblModel: UILabel!
    @IBOutlet var lblAssignUserCap: UILabel!
    @IBOutlet var lblAssignUser: UILabel!
    @IBOutlet var btnAssign: UIButton!
    @IBOutlet var btnEditService: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.btnMarkComplete.vwCornerRadius(radius: 16)
        self.btnAssign.vwCornerRadius(radius: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
