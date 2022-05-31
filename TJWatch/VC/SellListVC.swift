//
//  SellListVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 23/12/2021.
//

import UIKit
import RappleProgressHUD
import SDWebImage
import SideMenu

class SellListVC: UIViewController, UIViewControllerTransitioningDelegate
{
    @IBOutlet weak var lblSortText: UILabel!
    @IBOutlet weak var cltWatch: UICollectionView!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var vwEmpty: UIView!
    @IBOutlet weak var imgNoData: UIImageView!
    @IBOutlet weak var btnSortAscDESC: UIButton!
    @IBOutlet weak var btnPriceLowHigh: UIButton!
    @IBOutlet weak var vwSort: UIView!
    @IBOutlet weak var btnSortOpen: UIButton!
    @IBOutlet weak var btnMenuOL: UIButton!
    
    var arrWatch:[WatchData] = []
    var searchedText = ""
    var sort = "desc"
    var price = ""
    var isFromMenu = true
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.cltWatch.dataSource = self
        self.cltWatch.delegate = self
       // searchedText = Constants.appInfo.selectedMake
        self.imgNoData.setImgTintColor(colr: UIColor.lightGray)
        self.btnPriceLowHigh.vwBorderRadius(color: UIColor.white, bordrWidth: 1, radius: 12)
        self.btnSortAscDESC.vwBorderRadius(color: UIColor.white, bordrWidth: 1, radius: 12)
        self.btnPriceLowHigh.addTarget(self, action: #selector(self.priceLowHigh), for: .touchUpInside)
        self.btnSortAscDESC.addTarget(self, action: #selector(self.sortASCDESC), for: .touchUpInside)
        self.vwSort.backgroundColor = UIColor(red: 46/255, green: 46/255, blue: 31/255, alpha: 1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismisView), name: NSNotification.Name("dismisView"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.openSoldList), name: NSNotification.Name("openSoldList"), object: nil)
        self.refreshControl.tintColor = Constants.appColors.green
        self.refreshControl.addTarget(self, action: #selector(self.refereshData), for: .valueChanged)
        self.cltWatch.addSubview(refreshControl)
        self.cltWatch.alwaysBounceVertical = true
        if self.isFromMenu
        {
            self.btnMenuOL.setImage(UIImage(named: "menu"), for: .normal)
            //self.btnMenuOL.setBackgroundImage(UIImage(named: "menu"), for: .normal)
        }
        else
        {
            self.btnMenuOL.setImage(UIImage(named: "arrow-back"), for: .normal)
            //self.btnMenuOL.setBackgroundImage(UIImage(named: "arrow-back"), for: .normal)
        }
    }
    
    @objc private func refereshData()
    {
        self.searchedText = ""
        self.sort = "desc"
        self.price = ""
        self.getStock(filter: self.searchedText)
    }
    
    @objc private func openSoldList()
    {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SoldListVC") as! SoldListVC
        self.navigationController?.pushViewController(vw, animated: false)
    }
    
    @objc private func dismisView()
    {
        self.getStock(filter: self.searchedText)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getStock(filter: self.searchedText)
    }

    @IBAction func btnMenu(_ sender: Any)
    {
        if self.isFromMenu
        {
            let menu = storyboard!.instantiateViewController(withIdentifier: "sidemenu") as! SideMenuNavigationController
            menu.transitioningDelegate = self
            present(menu, animated: true, completion: nil)
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btnSearch(_ sender: Any)
    {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        vw.modalPresentationStyle = .overFullScreen
        vw.delegate = self
        self.present(vw, animated: true, completion: nil)
    }
    
    @IBAction func btnSortStock(_ sender: Any)
    {
        let btn = sender as! UIButton
        if btn.isSelected
        {
            btn.isSelected = false
            self.vwSort.isHidden = true
        }
        else
        {
            btn.isSelected = true
            self.vwSort.isHidden = false
        }
    }
    
    @objc private func sortASCDESC()
    {
        if self.sort == "asc"
        {
            sort = "desc"
        }
        else
        {
            sort = "asc"
        }
        self.price = ""
        self.btnSortOpen.isSelected = false
        self.vwSort.isHidden = true
        self.lblSortText.text = "Sort by (time: \(self.sort), price: \(self.price)"
        self.getStock(filter: self.searchedText)
    }
    @objc private func priceLowHigh()
    {
        if self.price == "low"
        {
            price = "high"
        }
        else
        {
            price = "low"
        }
        self.sort = ""
        self.btnSortOpen.isSelected = false
        self.vwSort.isHidden = true
        self.lblSortText.text = "Sort by (time: \(self.sort), price: \(self.price)"
        self.getStock(filter: self.searchedText)
    }
    
    @IBAction func btnNotifications(_ sender: Any) {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vw, animated: true)
    }
}
extension SellListVC:searchProtocol
{
    func searchSale(searchText: String)
    {
        self.searchedText = searchText
        self.getStock(filter: searchText)
    }
}
extension SellListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
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
        cell.lblYear.text = wt.watchYear
        cell.lblWatchNo.text = wt.ukWatchNo
        cell.lblSerialNo.text = wt.serialNo
        cell.lblPrice.text = " £" + wt.purchasePrice
        cell.lblPurchaseDate.text = wt.purchaseDate
        cell.imgWatch.sd_setImage(with: URL(string: wt.image), placeholderImage: UIImage(named: "placeholder"))
        if SharedManager.sharedInstance.userData.isAdmin.lowercased() == "true"
        {
            cell.btnDelete.isHidden = false
            cell.btnDelete.tag = indexPath.row + 100
            cell.btnDelete.addTarget(self, action: #selector(delItem(snder:)), for: .touchUpInside)
        }
        else
        {
            cell.btnDelete.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size-8, height: size+125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let vw = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SellDetailVC") as! SellDetailVC
        vw.productID = self.arrWatch[indexPath.row].purchaseID
        vw.modalPresentationStyle = .overFullScreen
        self.present(vw, animated: true, completion: nil)
    }
    
    @objc private func delItem(snder:UIButton)
    {
        let alert = UIAlertController(title: "Alert!", message: "Are you sure you want to delete this item?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
            self.deleteStockItem(id: self.arrWatch[snder.tag - 100].purchaseID)
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: { UIAlertAction in
        }))
        alert.view.tintColor = UIColor.black
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension SellListVC //api
{
    private func getStock(filter:String)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getAllStockSer(filters:filter,sort:self.sort, price: self.price)
        { response in
            switch(response.result)
            {
            case .success(_):
                RappleActivityIndicatorView.stopAnimation()
                if let _JSON = response.data
                {
                    if let json = try! JSONSerialization.jsonObject(with: _JSON) as? [String:Any]
                    {
                        self.refreshControl.endRefreshing()
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
                                self.arrWatch = []
                                for wt in dt {
                                    self.arrWatch.append(WatchData.fromJSON(wt))
                                }
                                RappleActivityIndicatorView.stopAnimation()
                                if self.arrWatch.count == 0
                                {
                                    self.vwEmpty.isHidden = false
                                    self.cltWatch.isHidden = true
                                }
                                else
                                {
                                    self.vwEmpty.isHidden = true
                                    self.cltWatch.isHidden = false
                                }
                                self.cltWatch.reloadData()
                                self.lblTotal.text = "\(self.arrWatch.count) Results"
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
    
    private func deleteStockItem(id:String)
    {
        RappleActivityIndicatorView.startAnimating(attributes: Constants.rappleAttribute.attributes)
        getDeleteStockItemByIDSer(id: id) { response in
            switch(response.result)
            {
            case .success(_):
                RappleActivityIndicatorView.stopAnimation()
                if let _JSON = response.data
                {
                    if let json = try! JSONSerialization.jsonObject(with: _JSON) as? [String:Any]
                    {
                        self.refreshControl.endRefreshing()
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
                            
                            if let msg = json["message"] as? String
                            {
                                let alert = UIAlertController(title: "Alert!", message: msg, preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { UIAlertAction in
                                    self.getStock(filter: self.searchedText)
                                }))
                                alert.view.tintColor = UIColor.black
                                self.present(alert, animated: true, completion: nil)
                                self.present(ActionHandler.showAlert(message: msg), animated: true, completion: nil)
                               
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
