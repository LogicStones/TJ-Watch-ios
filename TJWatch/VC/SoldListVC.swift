//
//  SoldListVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 31/12/2021.
//

import UIKit
import SDWebImage
import RappleProgressHUD
import Alamofire


class SoldListVC: UIViewController {

    @IBOutlet weak var imgNoData: UIImageView!
    @IBOutlet weak var vwEmpty: UIView!
    @IBOutlet weak var tblSold: UITableView!
    
    var arrSold:[SoldItem] = []
    let refreshControl = UIRefreshControl()

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.tblSold.delegate = self
        self.tblSold.dataSource = self
        self.imgNoData.setImgTintColor(colr: UIColor.lightGray)
        self.getSoldData(filter: "", datefrom: "", dateTo: "")
        self.refreshControl.tintColor = Constants.appColors.green
        self.refreshControl.addTarget(self, action: #selector(self.refereshData), for: .valueChanged)
        self.tblSold.addSubview(refreshControl)
        self.tblSold.alwaysBounceVertical = true
    }
    
    @objc private func refereshData()
    {
        self.getSoldData(filter: "", datefrom: "", dateTo: "")
    }

    
    @IBAction func btnBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNotifications(_ sender: Any) {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vw, animated: true)
    }
    @IBAction func btnSearchPopup(_ sender: Any) {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SoldSearchVC") as! SoldSearchVC
        vw.delegate = self
        self.present(vw, animated: true, completion: nil)
    }
}
extension SoldListVC:SoldSearchProtocol
{
    func searchSale(searchText: String, startDate: String, endDate: String) {
        self.getSoldData(filter: searchText, datefrom: startDate, dateTo: endDate)
    }
}

extension SoldListVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSold.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tblSold.dequeueReusableCell(withIdentifier: "SoldCell", for: indexPath) as! SoldCell
        let sold = self.arrSold[indexPath.row]
        cell.lblName.text = sold.watchName
        cell.lblDate.text = sold.soldDateTime
        cell.lblWatchNo.text = sold.ukWatchNo
        cell.lblSerialNo.text = sold.serialNo
        cell.lblModel.text = sold.model
        cell.lblYear.text = sold.year
        cell.lblBuyerName.text = sold.buyerName
        cell.lblBuyerContact.text = sold.buyerPhone
        cell.lblEmail.text = sold.buyerEmail
        cell.lblPrice.text =  "£"+sold.soldPrice
        cell.imgWatch.sd_setImage(with: URL(string: sold.img), placeholderImage: UIImage(named: "placeholder"))
        cell.btnInvoice.addTarget(self, action: #selector(self.generateInvoice(sndr:)), for: .touchUpInside)
        cell.btnInvoice.tag = indexPath.row + 100
        return cell
    }
    
    @objc private func generateInvoice(sndr:UIButton)
    {
        let sold = self.arrSold[sndr.tag - 100]
        let sUrl = sold.invoiceURL
        self.downloadReport(sUrl: sUrl, fileName: sold.watchName)
    }
    
    private func downloadReport(sUrl:String,fileName:String)
    {
        RappleActivityIndicatorView.startAnimatingWithLabel(NSLocalizedString("Downloading \(fileName) ...", comment: ""), attributes: Constants.rappleAttribute.attributesDash)
        AF.request(sUrl).responseData { (response) in
            if response.error == nil {
                RappleActivityIndicatorView.stopAnimation()
                print(response.result)
                if let data = response.data {
                    let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InvoiceVC") as! InvoiceVC
                    vw.downloadData = data
                    vw.heading = fileName
                    vw.modalPresentationStyle = .fullScreen
                    self.present(vw, animated: true, completion: nil)
                    //self.navigationController?.pushViewController(vw, animated: true)
//                    if self.saveFile(fileData: data, fileName: fileName)
//                    {
//                        print("file Save")
//                    }
//                    else
//                    {
//                        print("file not Save")
//                    }
                }
            }
            else
            {
                RappleActivityIndicatorView.stopAnimation()
                print("error on dowload")
                self.present(ActionHandler.showAlert(message: Constants.messgs.somethingWrong), animated: true, completion: nil)
            }
        }
        //        guard let url = URL(string: sUrl) else { return }
        //        let sessionConfig = URLSessionConfiguration.default
        //        sessionConfig.timeoutIntervalForRequest = 30.0
        //        sessionConfig.timeoutIntervalForResource = 60.0
        //        let urlSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue())
        //        let downloadTask = urlSession.downloadTask(with: url)
        //        downloadTask.resume()
    }
}
//extension SoldListVC:URLSessionDownloadDelegate {
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        RappleActivityIndicatorView.stopAnimation()
//        print("downloadLocation:", location)
//        // create destination URL with the original pdf name
//        guard let url = downloadTask.originalRequest?.url else { return }
//        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
//        // delete original copy
//        try? FileManager.default.removeItem(at: destinationURL)
//        // copy from temp to Document
//        do {
//            try FileManager.default.copyItem(at: location, to: destinationURL)
//            print(destinationURL)
//            DispatchQueue.main.async {
//                let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PDFVC") as! PDFVC
//                vw.path = destinationURL
//                //  vw.directory =
//                vw.heading = self.reportTitle
//                vw.modalPresentationStyle = .fullScreen
//                self.present(vw, animated: true, completion: nil)
//              //  self.navigationController?.pushViewController(vw, animated: true)
//            }
//
//        } catch let error {
//            print("Copy Error: \(error.localizedDescription)")
//        }
//    }
//}
extension SoldListVC //api get date
{
    private func getSoldData(filter:String,datefrom:String,dateTo:String)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
//        getSoldListSer(filter: String, datefrom: datefrom, dateTo: dateTo) {  in
//            <#code#>
//        }
        getSoldListSer(filter: filter, datefrom: datefrom, dateTo: dateTo) { response in
            switch(response.result)
            {
            case .success(_):
                RappleActivityIndicatorView.stopAnimation()
                self.refreshControl.endRefreshing()
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
                                self.arrSold = []
                                for mk in dt
                                {
                                    let servc = SoldItem.fromJSON(mk)
                                    self.arrSold.append(servc)
                                }
                                if self.arrSold.count == 0
                                {
                                    self.vwEmpty.isHidden = false
                                    self.tblSold.isHidden = true
                                }
                                else
                                {
                                    self.vwEmpty.isHidden = true
                                    self.tblSold.isHidden = false
                                }
                                self.tblSold.reloadData()
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
