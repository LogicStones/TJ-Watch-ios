//
//  CustomerVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 04/01/2022.
//
protocol customerSearch {
    func searchedClient(searched:Customer)
    func closeSearchClient()
}


import UIKit
import RappleProgressHUD

class CustomerVC: UIViewController
{

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tblClient: UITableView!
    @IBOutlet weak var vwEmpty: UIView!
    @IBOutlet weak var imgNoData: UIImageView!
    
    var arrClient:[Customer] = []
    var delegateCustomer:customerSearch!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.txtSearch.delegate = self
        self.btnSearch.vwCornerRadius(radius: 16)
        self.imgNoData.setImgTintColor(colr: UIColor.lightGray)
        self.btnSearch.addTarget(self, action: #selector(self.searchClient), for: .touchUpInside)
        self.tblClient.delegate = self
        self.tblClient.dataSource = self
        self.tblClient.tableFooterView = UIView()
    }
    
    @IBAction func btnBac(_ sender: Any)
    {
        self.delegateCustomer.closeSearchClient()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func searchClient()
    {
        if self.txtSearch.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Pleae enter client name"), animated: true, completion: nil)
            return
        }
        self.getClient()
    }
   
}
extension CustomerVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrClient.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vw = self.tblClient.dequeueReusableCell(withIdentifier: "CustomerCell", for: indexPath) as! CustomerCell
        let clnt = self.arrClient[indexPath.row]
        vw.lblName.text = clnt.name
        vw.lblEmail.text = clnt.email
        vw.lblPhone.text = clnt.phone
        vw.selectionStyle = .none
        return vw
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let clnt = self.arrClient[indexPath.row]
        self.delegateCustomer.searchedClient(searched: clnt)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CustomerVC //api get data
{
    private func getClient()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getClientSearchSer(name: self.txtSearch.text!)
        { response in
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
                                self.arrClient = []
                                for cl in dt
                                {
                                    let clnt = Customer.fromJSON(cl)
                                    self.arrClient.append(clnt)
                                }
                                if self.arrClient.count == 0
                                {
                                    self.vwEmpty.isHidden = false
                                    self.tblClient.isHidden = true
                                }
                                else
                                {
                                    self.vwEmpty.isHidden = true
                                    self.tblClient.isHidden = false
                                }
                                self.tblClient.reloadData()
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
extension CustomerVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == ""
        {
            // User presses backspace
            textField.deleteBackward()
        } else {
            // User presses a key or pastes
            textField.insertText(string.uppercased())
        }
        // Do not let specified text range to be changed
        return false
    }
}
