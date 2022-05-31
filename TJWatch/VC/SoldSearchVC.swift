//
//  SoldSearchVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 09/03/2022.
//
protocol SoldSearchProtocol
{
    func searchSale(searchText:String, startDate:String, endDate:String)
}

import UIKit

class SoldSearchVC: UIViewController {

    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var txtStartDate: UITextField!
    @IBOutlet var txtEndDate: UITextField!
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var vwDatePick: UIView!
    @IBOutlet var dtPickr: UIDatePicker!
    @IBOutlet var btnDone: UIButton!
    @IBOutlet var btnCancel: UIButton!
    
    var isStartDate = -1
    var isEndDate = -1
    var delegate:SoldSearchProtocol!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.btnSearch.vwCornerRadius(radius: 22)
        self.btnSearch.addTarget(self, action: #selector(self.search), for: .touchUpInside)
        self.btnDone.vwBorderRadius(color: UIColor(red: 18/255, green: 78/255, blue: 68/255, alpha: 1.0), bordrWidth: 1, radius: 12)
        self.btnCancel.vwBorderRadius(color: UIColor(red: 18/255, green: 78/255, blue: 68/255, alpha: 1.0), bordrWidth: 1, radius: 12)
        self.dtPickr.date = Date()
//        self.dtPickr.minimumDate = Date()
        self.btnDone.addTarget(self, action: #selector(self.doneDate), for: .touchUpInside)
        self.btnCancel.addTarget(self, action: #selector(self.cancelDate), for: .touchUpInside)
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneDate()
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        if self.isStartDate != -1
        {
            self.txtStartDate.text = formatter.string(from: self.dtPickr.date)
        }
        else if self.isEndDate != -1
        {
            self.txtEndDate.text = formatter.string(from: self.dtPickr.date)
        }
        self.vwDatePick.isHidden = true
    }
    
    @objc private func cancelDate()
    {
        self.vwDatePick.isHidden = true
    }
    
    @IBAction func btnStartDate(_ sender: Any)
    {
        self.isStartDate = 1
        self.isEndDate = -1
        self.vwDatePick.isHidden = false
    }
    
    @IBAction func btnEndDate(_ sender: Any)
    {
        self.isStartDate = -1
        self.isEndDate = 1
        self.vwDatePick.isHidden = false
    }
    
    @objc func search()
    {
        self.delegate.searchSale(searchText: self.txtSearch.text!, startDate: self.txtStartDate.text!, endDate: self.txtEndDate.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
}
