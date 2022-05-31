//
//  Constants.swift
//  DawgTales
//
//  Created by Abubakar on 11/04/2020.
//  Copyright © 2020 LS. All rights reserved.
//

import Foundation
import UIKit
import RappleProgressHUD


struct Constants {
    
    struct  Server {
        static let baseUrl = "http://trotters.azurewebsites.net/api"
        static let downloadUrl = "https://admin.rtdhuttons.com/Home"
        static let referralImageUrl = "https://admin.rtdhuttons.com/images/Referrals/"
        //"https://testdocapi.agiletechstudio.net/api/"
    }
    
    struct tokens {
      //  static var authToken = ""
        static var deviceToken = "00"
    }
    
    struct appInfo {
        static let appstoreID = "1542784855"
        static var selectedMake = ""
    }
    
    struct appColors {
        static let appGrayColor =  UIColor(red: 37/255, green: 50/255, blue: 72/255, alpha: 1.0)
        static let appSilverClr = UIColor.white //UIColor(red: 160/255, green: 160/255, blue: 162/255, alpha: 1.0)
        static let blue = UIColor(red: 20/255, green: 0/255, blue: 87/255, alpha: 1.0)
        static let ligtBlack = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1.0)
        static let lightGray = UIColor(red: 126/255, green: 127/255, blue: 126/255, alpha: 1.0)
        static let green = UIColor(red: 22/255, green: 148/255, blue: 99/255, alpha: 1.0)
        
        static let txtBrdClr = UIColor(red: 193/255, green: 193/255, blue: 193/255, alpha: 1.0)
    }
   
    struct api
    {
        static let login = "JewelleryApi/Login"
        static let getStock = "JewelleryApi/GetAllItemsStock"
        static let getStockDetail = "JewelleryApi/GetItemDetailById"
        static let getMakeList = "JewelleryApi/GetMakeList"
        static let completeService = "JewelleryApi/ServiceStatus"
        static let getAllServices = "JewelleryApi/GetAllService"
        static let getSoldList = "JewelleryApi/GetAllSales"
        static let getClients = "JewelleryApi/GetClientByName"
        static let getBoxPaper = "JewelleryApi/GetBoxPaperTypes"
        static let getPendingOrder = "JewelleryApi/GetAllPendingOrders"
        static let getBuyTypes = "JewelleryApi/GetProductBuyTypes"
        static let getPendingOrderByID = "JewelleryApi/GetPendingOrderById"
        static let getAllLiveDeposits = "JewelleryApi/GetAllLiveDeposits"
        static let getLiveDepositById = "JewelleryApi/GetLiveDepositById"
        static let getDashboard = "JewelleryApi/GetDashboardStatistics"
        static let getNotifications = "JewelleryApi/GetAllNotifications"
        static let getItemDetailById = "JewelleryApi/GetItemDetailById"
        static let editProduct = "JewelleryApi/EditProduct"
        static let delStockItem = "JewelleryApi/DeleteStock"
        static let updateDeviceToken = "JewelleryApi/UpdateDeviceToken"
        static let cancelPendingOrder = "JewelleryApi/CancelPendingOrder"
        static let cancelLiverDeposit = "JewelleryApi/CancelLiveDeposit"
        static let getAllUsers = "JewelleryApi/GetAllUsers"
        static let assignServiceToSalesman = "JewelleryApi/AssignService"
        static let getServiceDetailByID = "JewelleryApi/GetServiceById"
    }
    
    struct reportName
    {
        static let IntReport = "RTD Intelligence Report"
        static let marketAnaylsis = "RTD Analysis Report"
    }
    
    struct rappleAttribute {
        static let attributes = RappleActivityIndicatorView.attribute(style: RappleStyle.apple, tintColor: UIColor.white, screenBG: .lightText, progressBG: .black, progressBarBG: .orange, progreeBarFill: .blue, thickness: 4)
        static let attributesDash = RappleActivityIndicatorView.attribute(style: RappleStyle.apple, tintColor: UIColor.white, screenBG: .gray, progressBG: .black, progressBarBG: .orange, progreeBarFill: .blue, thickness: 4)
    }
    
    struct apiKeys
    {
       
    }
    
    struct messgs {
        static let somethingWrong = NSLocalizedString("Something wrong! Please try again later", comment: "")
        static let conectivityNotAvailable = NSLocalizedString("Check your internet connection", comment: "")
        static let emailIncorrect = NSLocalizedString("Enter correct email address", comment: "")
        static let emailEmpt = NSLocalizedString("First enter email address", comment: "")
        static let passwordEmpt = NSLocalizedString("First enter password", comment: "")
        static let fNameEmpt = NSLocalizedString("First enter first name", comment: "")
        static let lNameEmpt = NSLocalizedString("First enter last name", comment: "")
        static let entrUserName = NSLocalizedString("First enter username", comment: "")
        static let entrPhone = NSLocalizedString("First enter phone number", comment: "")
        static let entrCENo = NSLocalizedString("First enter CENo", comment: "")
        static let entrBn = NSLocalizedString("First enter businessName", comment: "")
        static let entrDesignation = NSLocalizedString("First enter designation", comment: "")
        static let confirmPassword = NSLocalizedString("First enter confirm password", comment: "")
        static let phoneEmpt = NSLocalizedString("First enter phone number", comment: "")
        static let passwordMismatch = NSLocalizedString("password mismatch", comment: "")
        static let newPassword = NSLocalizedString("First enter new password", comment: "")
        static let pleaseSelect = NSLocalizedString("Please select", comment: "")
        static let cancel = NSLocalizedString("Cancel", comment: "")
        static let takeFromCamera = NSLocalizedString("Take From Camera", comment: "")
        static let pickFromGellary = NSLocalizedString("Pick From Gallery", comment: "")
        static let successRegister = NSLocalizedString("successfully register, verify your email and login", comment: "")
        static let successChangePass = NSLocalizedString("successfully change password", comment: "")
        static let imgNotSelect = NSLocalizedString("First take/choose profile picture", comment: "")
        static let noTimeSlot = NSLocalizedString("Select time slot", comment: "")
        static let noBookingDateTime = NSLocalizedString("Please first select date and time slot", comment: "")
        static let messageHere = NSLocalizedString("Message here", comment: "")
        static let messageEmpty = NSLocalizedString("First enter message", comment: "")
        static let confirmation = NSLocalizedString("CONFIRMATION", comment: "")
        static let cancelTrainingMsg = NSLocalizedString("Are you sure you want to cancel training?", comment: "")
        static let noTraineeFound = NSLocalizedString("No Trainee Found", comment: "")
        static let wrongImage = NSLocalizedString("Wrong image type selection, Please select gif image", comment: "")
        static let selectWorkoutImg = NSLocalizedString("Select workout image", comment: "")
        static let selectCat = NSLocalizedString("Select Category", comment: "")
        static let entrCat = NSLocalizedString("First enter Category", comment: "")
        static let enterTitle = NSLocalizedString("First enter Title", comment: "")
        static let alert = NSLocalizedString("Alert!", comment: "")
        static let blueToothPermission = NSLocalizedString("Bluetooth permission is currently disabled for the application. Enable Bluetooth from the application settings.", comment: "")
        static let settings = NSLocalizedString("Settings", comment: "")
        
    }
    
    struct msgApiKeys {
        static let forgotSuccess = NSLocalizedString("New password sent to email address", comment: "")
        static let uploadedSuccess = NSLocalizedString("Successfully uploaded", comment: "")
        static let notFound = msgApiKeys.invalidUserNameOrPassword
        static let accountLocked = NSLocalizedString("Account blocked, Please contact administrator", comment: "")
        static let emailNotVerified = NSLocalizedString("Email not verified, Please confirm your email to login", comment: "")
        static let success = NSLocalizedString("Successfully", comment: "")
        static let invalidUserNameOrPassword = NSLocalizedString("Invalid email or password", comment: "")
        static let invalidParameters = messgs.somethingWrong
        static let alreadyExists = NSLocalizedString("Email already exist, Please provide another", comment: "")
        static let invalidCurrentPassword = NSLocalizedString("Incorrect current password", comment: "")
        static let catAlreadyExists = NSLocalizedString("Category already exist, try another", comment: "")
        static let notScheduledNow = NSLocalizedString("Not scheduled now", comment: "")
        static let timePast = NSLocalizedString("Training is expired", comment: "")
    }
    
}

