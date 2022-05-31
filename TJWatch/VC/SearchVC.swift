//
//  SearchVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 31/12/2021.
//

protocol searchProtocol
{
    func searchSale(searchText:String)
}

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    var delegate:searchProtocol!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.txtSearch.delegate = self
        self.btnSearch.vwCornerRadius(radius: 22)
        self.btnSearch.addTarget(self, action: #selector(self.search), for: .touchUpInside)
    }
    
    @objc private func search()
    {
        if self.txtSearch.text == ""
        {
            self.present(ActionHandler.showAlert(message: "Please enter search"), animated: true, completion: nil)
            return
        }
        
        self.delegate.searchSale(searchText: self.txtSearch.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension SearchVC:UITextFieldDelegate
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
