//
//  SoldCell.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 31/12/2021.
//

import UIKit

class SoldCell: UITableViewCell {

    @IBOutlet weak var imgWatch: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWatchNo: UILabel!
    @IBOutlet weak var lblSerialNo: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblBuyerName: UILabel!
    @IBOutlet weak var lblBuyerContact: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnInvoice: UIButton!
    @IBOutlet var btnDel: UIButton!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.btnInvoice.vwCornerRadius(radius: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}
