//
//  MenuVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 30/12/2021.
//

import UIKit
import SDWebImage

class MenuVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var lblUserID: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var tblMenu: UITableView!
    
    var arrMenu = ["In Stock", "Sold Products", "Service List", "Add Pending Orders", "Pending Orders", "Live Deposit", "Logout"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let user = UserLogin.getFrmUD()
        self.lblUserName.text = user.name
        self.lblUserID.text = user.id
        self.imgUser.sd_setImage(with: URL(string: user.imageUrl), placeholderImage: UIImage(named: "Sample"))
        self.imgUser.vwCornerRadius(radius: 37.5)
        self.tblMenu.dataSource = self
        self.tblMenu.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblMenu.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        let menu = self.arrMenu[indexPath.row]
        cell.lblMenuName.text = menu
        switch menu {
        case "In Stock":
            cell.imgMenu.image = UIImage.init(named: "In-Stock")
            break
        case "Sold Products":
            cell.imgMenu.image = UIImage.init(named: "SoldOut")
            break
        case "Service List":
            cell.imgMenu.image = UIImage.init(named: "ServiceList")
            break
        case "Add Pending Orders":
            cell.imgMenu.image = UIImage.init(named: "ServiceList")
            break
        case "Pending Orders":
            cell.imgMenu.image = UIImage.init(named: "ServiceList")
            break
        case "Live Deposit":
            cell.imgMenu.image = UIImage.init(named: "ServiceList")
            break
//        case "Notifcations":
//            cell.imgMenu.image = UIImage.init(named: "ServiceList")
//            break
        default:
            cell.imgMenu.image = UIImage.init(named: "Logout")
            break
        }
        cell.selectionStyle = . none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let menu = self.arrMenu[indexPath.row]
       
        switch menu {
        case "In Stock":
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbarVC") as! UITabBarController
            vw.selectedIndex = 2
            self.navigationController?.pushViewController(vw, animated: false)
           // self.dismiss(animated: true, completion: nil)
            break
        case "Sold Products":
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SoldListVC") as! SoldListVC
            self.navigationController?.pushViewController(vw, animated: true)
            break
        case "Service List":
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ServiceListVC") as! ServiceListVC
            self.navigationController?.pushViewController(vw, animated: true)
            break
        case "Add Pending Orders":
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPendingOrderVC") as! AddPendingOrderVC
            self.navigationController?.pushViewController(vw, animated: true)
            break
        case "Pending Orders":
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PendingOrders") as! PendingOrders
            self.navigationController?.pushViewController(vw, animated: true)
            break
        case "Live Deposit":
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LiveDepositeVC") as! LiveDepositeVC
            self.navigationController?.pushViewController(vw, animated: true)
            break
//        case "Notifcations":
//            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
//            self.navigationController?.pushViewController(vw, animated: true)
//            break
        default:
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC")  as! LoginVC
            UserLogin.removeFromUD()
            self.navigationController?.pushViewController(vw, animated:false)
            break
        }
    }

}
