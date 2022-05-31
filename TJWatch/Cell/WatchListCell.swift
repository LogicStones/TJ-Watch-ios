//
//  WatchListCell.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 23/12/2021.
//

import UIKit

class WatchListCell: UICollectionViewCell {
    @IBOutlet weak var imgWatch: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblWatchNo: UILabel!
    @IBOutlet weak var lblSerialNo: UILabel!
    @IBOutlet var btnDelete: UIButton!
    
    @IBOutlet var lblPurchaseDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblYear: UILabel!
}
