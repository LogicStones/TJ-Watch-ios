//
//  NotificationVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 04/02/2022.
//

import UIKit
import RappleProgressHUD

class NotificationVC: UIViewController {

    @IBOutlet weak var tblNotification: UITableView!
    
    var arrNotification:[Notification] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tblNotification.delegate = self
        self.tblNotification.dataSource = self
        self.getAllNotification()
    }
    
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NotificationVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblNotification.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let notf = self.arrNotification[indexPath.row]
        cell.lblHeading.text = notf.title
        cell.lblDate.text = notf.insertedDT
        cell.lblMessage.text = notf.descrption
        if notf.type.lowercased() == "v"
        {
            cell.constrainBottomMessage.constant = 45
            cell.btnViewReport.isHidden = false
        }
        else
        {
            cell.constrainBottomMessage.constant = 10
            cell.btnViewReport.isHidden = true
        }
        cell.selectionStyle = .none
        cell.btnViewReport.tag = indexPath.row + 100
        cell.btnViewReport.addTarget(self, action: #selector(openViewReport(sndr:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notf = self.arrNotification[indexPath.row]
        switch notf.type.lowercased() {
//        case "v":
//            if let url = URL(string: notf.link), UIApplication.shared.canOpenURL(url) {
//                UIApplication.shared.open(url)
//            }
//            break
        case "s":
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SoldListVC") as! SoldListVC
            self.navigationController?.pushViewController(vw, animated: true)
            break
        case "b":
            let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SellListVC") as! SellListVC
            vw.isFromMenu = false
            self.navigationController?.pushViewController(vw, animated: true)
            break
        default:
            break
        }
    }
    @objc private func openViewReport(sndr:UIButton)
    {
        let notf = self.arrNotification[sndr.tag - 100]
        if let url = URL(string: notf.link), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
    }
}
extension NotificationVC //api
{
    private func getAllNotification()
    {
        getNotificationsSer { response in
            switch(response.result)
            {
            case .success(_):
                RappleActivityIndicatorView.stopAnimation()
                if let _JSON = response.data
                {
                    if let json = try! JSONSerialization.jsonObject(with: _JSON) as? [String:Any]
                    {
                        if json["error"] as! Bool
                        {
                            if let msg = json["message"] as? String
                            {
                                self.present(ActionHandler.showAlertPopViewController(message: msg, vw: self), animated: true, completion: nil)
                                //  self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
                            }
                            else
                            {
                                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            if let dt = json["data"] as? [[String:Any]]
                            {
                                self.arrNotification = []
                                for not in dt
                                {
                                    let notif = Notification.fromJSON(not)
//                                    notif.descrption = "e-9mmoeSlEDBrXW8OlUU4c:APA91bERUJq7FL9Zgi81lpR1sWnfJdWRjzr4EvG1LkPICGTSjaPP9RdoZoduG4rHFWKK18gP0Lu3Y8mUZlAE0KJurKzi6noM5PT-V-hTxNzTyz-Lq_ELdqixCJbh2xrIBKJkVRqDEh8t e-9mmoeSlEDBrXW8OlUU4c:APA91bERUJq7FL9Zgi81lpR1sWnfJdWRjzr4EvG1LkPICGTSjaPP9RdoZoduG4rHFWKK18gP0Lu3Y8mUZlAE0KJurKzi6noM5PT-V-hTxNzTyz-Lq_ELdqixCJbh2xrIBKJkVRqDEh8t e-9mmoeSlEDBrXW8OlUU4c:APA91bERUJq7FL9Zgi81lpR1sWnfJdWRjzr4EvG1LkPICGTSjaPP9RdoZoduG4rHFWKK18gP0Lu3Y8mUZlAE0KJurKzi6noM5PT-V-hTxNzTyz-Lq_ELdqixCJbh2xrIBKJkVRqDEh8t"
                                    self.arrNotification.append(notif)
                                }
                                self.tblNotification.reloadData()
                            }
                        }
                    }
                }
                break
            case .failure(_):
                RappleActivityIndicatorView.stopAnimation()
                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
                break
            }
        }
    }
}
