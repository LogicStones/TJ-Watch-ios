//
//  InvoiceVC.swift
//  TJWatch
//
//  Created by Abubakar Gulzar on 05/01/2022.
//

import UIKit
import PDFKit

class InvoiceVC: UIViewController {

    @IBOutlet weak var vwPDF: PDFView!
    var downloadData:Data!
    var document:PDFDocument!
    var heading = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pdfDocument = PDFDocument(data: self.downloadData) {
            vwPDF.displayMode = .singlePageContinuous
            vwPDF.autoScales = true
            vwPDF.displayDirection = .vertical
            self.document = pdfDocument
            vwPDF.document = pdfDocument
        }
    }
    
    @IBAction func btnBack(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
