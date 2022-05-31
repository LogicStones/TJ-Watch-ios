//
//  SalemanVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 23/04/2022.
//

import UIKit
import SDWebImage
import RappleProgressHUD

protocol salesmanProtocol {
    func selectSalesman(saleman:Salesman)
}

class SalemanVC: UIViewController {
    
    @IBOutlet var tblSalesmane: UITableView!
    
    var arrSalesman:[Salesman] = []
    var delegate:salesmanProtocol!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.getSalesMan()
        self.tblSalesmane.delegate = self
        self.tblSalesmane.dataSource = self
    }
    
    @IBAction func btnClose(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SalemanVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.arrSalesman.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = self.tblSalesmane.dequeueReusableCell(withIdentifier: "SalesmanCell", for: indexPath) as! SalesmanCell
        let sal = self.arrSalesman[indexPath.row]
        cell.lblName.text = sal.userName
        cell.lblTotalSold.text = "User ID: \(sal.id)"
        cell.imgSaleman.sd_setImage(with: URL(string: sal.image), placeholderImage: UIImage(named: "placeholder.png"))
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.delegate.selectSalesman(saleman: self.arrSalesman[indexPath.row])
        self.dismiss(animated: true)
    }
}

extension SalemanVC //api
{
    private func getSalesMan()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getAllUsersSer { response in
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
                                self.arrSalesman = []
                                for mk in dt
                                {
                                    let sal = Salesman.fromJSON(mk)
                                    self.arrSalesman.append(sal)
                                }
                                if self.arrSalesman.count == 0
                                {
                                    //self.vwEmpty.isHidden = false
                                    self.tblSalesmane.isHidden = true
                                }
                                else
                                {
                                    //self.vwEmpty.isHidden = true
                                    self.tblSalesmane.isHidden = false
                                }
                                self.tblSalesmane.reloadData()
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
