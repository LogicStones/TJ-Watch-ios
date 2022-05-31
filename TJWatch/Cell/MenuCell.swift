//
//  MenuCell.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 30/12/2021.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var lblMenuName: UILabel!
    @IBOutlet weak var imgMenu: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
