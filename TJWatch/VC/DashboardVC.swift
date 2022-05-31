//
//  DashboardVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 02/02/2022.
//

import UIKit
import RappleProgressHUD
import SideMenu
import SDWebImage
import Alamofire


class DashboardVC: UIViewController, UIViewControllerTransitioningDelegate
{
    
    @IBOutlet weak var stkMain: UIStackView!
    @IBOutlet weak var tblMake: UITableView!
    @IBOutlet weak var tblSalesMan: UITableView!
    @IBOutlet var cltWatch: UICollectionView!
    
    var arrMake:[WatchMake] = []
    var arrSaleman:[Salesman] = []
    var arrWatch:[WatchData] = []
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblMake.delegate = self
        self.tblMake.dataSource = self
        self.tblSalesMan.delegate = self
        self.tblSalesMan.dataSource = self
        self.tblMake.tableFooterView = UIView()
        self.tblSalesMan.tableFooterView = UIView()
        self.cltWatch.delegate = self
        self.cltWatch.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getDashboard()
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        let menu = storyboard!.instantiateViewController(withIdentifier: "sidemenu") as! SideMenuNavigationController
        menu.transitioningDelegate = self
        present(menu, animated: true, completion: nil)
    }
    
    @IBAction func btnNotifications(_ sender: Any) {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vw, animated: true)
    }
    
}
extension DashboardVC:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tblMake
        {
            return self.arrMake.count
        }
        else
        {
            return self.arrSaleman.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if tableView == self.tblMake
        {
            let cell = self.tblMake.dequeueReusableCell(withIdentifier: "MakeCell", for: indexPath) as! MakeCell
            let make = self.arrMake[indexPath.row]
            cell.lblName.text = make.make
            cell.lblTotalWatch.text = "Total Watches: \(make.total)"
            cell.imgBrand.layer.cornerRadius = cell.imgBrand.frame.height / 2.0
            cell.imgBrand.clipsToBounds = true
            cell.imgBrand.sd_setImage(with: URL(string: make.logo), placeholderImage: UIImage(named: "placeholder.png"))
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            let cell = self.tblSalesMan.dequeueReusableCell(withIdentifier: "SalesmanCell", for: indexPath) as! SalesmanCell
            let sl = self.arrSaleman[indexPath.row]
            cell.lblName.text = sl.userName
            cell.lblTotalSold.text = "Product Sold: " + sl.soldProduct
            cell.lblTotalSale.text = "Total Sale: £" + sl.totalSale
            cell.imgSaleman.sd_setImage(with: URL(string: sl.image), placeholderImage: UIImage(named: "placeholder.png"))
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tblMake
        {
            //Constants.appInfo.selectedMake = self.arrMake[indexPath.row].make
            let vc = self.tabBarController!.viewControllers![2] as! SellListVC
            vc.searchedText = self.arrMake[indexPath.row].make
            self.tabBarController?.selectedIndex = 2
        }
    }
    
    
}
extension DashboardVC
{
    private func getDashboard()
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        let user = SharedManager.sharedInstance.userData
        
        getDashboardSer(isAdmin: user!.isAdmin.lowercased()) { response in
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
                            if let dt = json["data"] as? [String:Any]
                            {
                                self.arrMake = []
                                self.arrSaleman = []
                                self.arrWatch = []
                                if let mk = dt["lstCompanyWatch"] as? [[String:Any]]
                                {
                                    
                                    for m in mk
                                    {
                                        self.arrMake.append(WatchMake.fromJSON(m))
                                    }
                                    
                                }
                                if let sl = dt["lstSalesMen"] as? [[String:Any]]
                                {
                                    for s in sl
                                    {
                                        self.arrSaleman.append(Salesman.fromJSON(s))
                                    }
                                    
                                }
                                if let sp = dt["recentSoldProducts"] as? [[String:Any]]
                                {
                                    for s in sp
                                    {
                                        self.arrWatch.append(WatchData.fromJSON(s))
                                    }
                                }
                                self.cltWatch.reloadData()
                                self.tblMake.reloadData()
                                self.startTimer()
                                self.pageControl.numberOfPages = self.arrWatch.count / 2
                                if SharedManager.sharedInstance.userData.isAdmin.lowercased() == "false"
                                {
                                    self.stkMain.distribution = .fillProportionally
                                    self.tblSalesMan.isHidden = true
                                }
                                else
                                {
                                    self.stkMain.distribution = .fillEqually
                                    self.tblSalesMan.isHidden = false
                                }
                                self.tblSalesMan.reloadData()
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
extension DashboardVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrWatch.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = self.cltWatch.dequeueReusableCell(withReuseIdentifier: "WatchListCell", for: indexPath) as! WatchListCell
        // cell.contentView.dropShadowView()
        let wt = self.arrWatch[indexPath.row]
        cell.imgWatch.vwCornerRadius(radius: 10)
        cell.lblName.text = wt.make + " " + wt.model
        cell.lblModel.text =  wt.model
        cell.lblPrice.text = " £" + wt.purchasePrice
        cell.imgWatch.sd_setImage(with: URL(string: wt.image), placeholderImage: UIImage(named: "placeholder"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        
        return CGSize(width: size-20, height: size-30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func startTimer() {
        
        let timer =  Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
        if pageControl.currentPage == pageControl.numberOfPages - 1 {
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage += 1
        }
        self.cltWatch.scrollToItem(at: IndexPath(row: pageControl.currentPage, section: 0), at: .right, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sold = self.arrWatch[indexPath.row]
        let sUrl = sold.pdfUrl
        self.downloadReport(sUrl: sUrl, fileName: sold.make + " " + sold.model)
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
