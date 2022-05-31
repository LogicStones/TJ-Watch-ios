//
//  Services.swift
//  CanTaxi
//
//  Created by Abubakar on 16/01/2019.
//  Copyright © 2019 Abubakar. All rights reserved.
//

import Foundation
import Alamofire

public func loginSer(UserName:String, UserPassword:String, DeviceId:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = [
        "UserName":UserName,
        "UserPassword":UserPassword,
        "DeviceId":DeviceId
    ]
    sendPostRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.login, parameters: parameters, completion: completion)
}

public func getAllStockSer(filters:String, sort:String, price:String, completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["filters":filters,"sort":sort,"price":price]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getStock ,parameters: parameters, completion: completion)
}
public func getStockDetailSer(id:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["id":id]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getStockDetail ,parameters: parameters, completion: completion)
}

public func getMakeListSer(completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = [:]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getMakeList, parameters: parameters, completion: completion)
}
//getBuyTypes
public func getBuyTypesSer(completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = [:]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getBuyTypes, parameters: parameters, completion: completion)
}
//getPendingOrderByID
public func getPendingOrderByIDSer(id:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = [
        "id":id
    ]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getPendingOrderByID, parameters: parameters, completion: completion)
}
//get live deposit
public func getAllLiveDepositSer(sort:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters =
    [
        "sort":sort
    ]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getAllLiveDeposits, parameters: parameters, completion: completion)
}
//get live deposit by id
public func getLiveDepositByIDSer(id:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters =
    [
        "id":id
    ]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getLiveDepositById, parameters: parameters, completion: completion)
}
public func getCompleteServiceSer(ServiceId:String, BalPayment:String ,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters =
    ["ServiceId":ServiceId,
     "BalPayment":BalPayment
    ]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.completeService, parameters: parameters, completion: completion)
}
public func getAllServiceSer(servicestatus:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters =
    ["servicestatus":servicestatus
    ]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getAllServices, parameters: parameters, completion: completion)
}

public func getSoldListSer(filter:String,datefrom:String,dateTo:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["filter":filter,"datefrom":datefrom,"dateTo":dateTo]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getSoldList, parameters: parameters, completion: completion)
}

public func getClientSearchSer(name:String, completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["Name":name]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getClients, parameters: parameters, completion: completion)
}

public func getPendingOrdersSer(sort:String, completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["sort":sort]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getPendingOrder, parameters: parameters, completion: completion)
}

public func getBoxPaperListSer(completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = [:]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getBoxPaper, parameters: parameters, completion: completion)
}

public func getDashboardSer(isAdmin:String, completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["isadmin":isAdmin]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getDashboard, parameters: parameters, completion: completion)
}
//getNotifications
public func getNotificationsSer(completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = [:]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getNotifications, parameters: parameters, completion: completion)
}

public func getItemDetaidByIDSer(id:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["id":id]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getItemDetailById, parameters: parameters, completion: completion)
}

public func getDeleteStockItemByIDSer(id:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters =
    [
        "id":id
    ]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.delStockItem, parameters: parameters, completion: completion)
}

public func updateDeivceToken(UserId:String,DeviceToken:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["UserId":UserId,"DeviceToken":DeviceToken]
    sendPostRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.updateDeviceToken, parameters: parameters, completion: completion)
}

//cancel pending order
public func getCancelPendingOrderIDSer(id:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters =
    [
        "Id":id
    ]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.cancelPendingOrder, parameters: parameters, completion: completion)
}
//cancel live deposit
public func getCancelLiveDepositByIDSer(id:String,completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters =
    [
        "Id":id
    ]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.cancelLiverDeposit, parameters: parameters, completion: completion)
}
//get all users
public func getAllUsersSer(completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = [:]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getAllUsers, parameters: parameters, completion: completion)
}
//assign to salesman
public func serviceAssignToSalesmanSer(serviceId:String, userId:String, completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["serviceId":serviceId, "userId":userId]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.assignServiceToSalesman, parameters: parameters, completion: completion)
}
public func getServiceDetailByIDSer(Id:String, completion: @escaping (AFDataResponse<String>) -> Void)
{
    let parameters: Parameters = ["Id":Id]
    sendGetRequest(baseURL: Constants.Server.baseUrl,url: Constants.api.getServiceDetailByID, parameters: parameters, completion: completion)
}

func sendGetRequest(baseURL:String, url: String,parameters: Parameters, completion: @escaping (AFDataResponse<String>) -> Void) -> Void {
    let headers = HTTPHeaders.init([
        "Content-Type": "application/x-www-form-urlencoded"
    ])
    AF.request("\(baseURL)/" + url, method: .get,parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString { response in
            completion(response)
        }
}

func sendPostRequest(baseURL:String,url: String, parameters: Parameters, completion: @escaping (AFDataResponse<String>) -> Void) -> Void {
    let headers = HTTPHeaders.init([
        "Content-Type": "application/x-www-form-urlencoded"
    ])
    
        AF.request("\(baseURL)/" + url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseString { response in
            completion(response)
        }
}
func postRequestWithData(url:String, body:Data,completion: @escaping (AFDataResponse<String>) -> Void) -> Void {
    var req = URLRequest(url: URL(string: url)!)
    req.method = .post
    req.httpBody = body
    req.headers = HTTPHeaders.init([
                                    "Content-Type":"application/json"])
    
    AF.request(req).responseString { (response) in
        completion(response)
    }
    
}

