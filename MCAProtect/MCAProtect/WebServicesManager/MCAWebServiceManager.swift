//
//  MCAWebServiceManager.swift
//  MCAProtect
//
//  Created by Manjunath on 28/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MCAWebServiceManager: NSObject
{

    var baseURL : String!
    // Can't init is singleton
    private override init() {
        baseURL  = MCAUtilities.getBaseURL(environment: "ENVIRONMENT")
    }
    
    //MARK: Shared Instance
    
    static let sharedWebServiceManager: MCAWebServiceManager = MCAWebServiceManager()

    
    
    
    
    func postRequest(requestParam: Dictionary<String , Any>,
                     endPoint: String?,
                successCallBack: @escaping (_ responseData: Dictionary<String , AnyObject>) -> Void,
                failureCallBack: @escaping (_ error: Error) -> Void)
    {
        
        
        
        var headersDict : Dictionary<String,String> = Dictionary()
        headersDict["Content-Type"] = "application/json ; charset=utf-8"
        headersDict["Accept"] = "application/json"
        if nil != MCASessionManager.sharedSessionManager.accessToken
        {
            headersDict["Access-Token"] = MCASessionManager.sharedSessionManager.accessToken
        }
        if nil != MCASessionManager.sharedSessionManager.client
        {
            headersDict["Client"] = MCASessionManager.sharedSessionManager.client
        }
        if nil != MCASessionManager.sharedSessionManager.uid
        {
            headersDict["Uid"] = MCASessionManager.sharedSessionManager.uid
        }
        


        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)
        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .post, parameters: requestParam, encoding: URLEncoding.queryString, headers: headersDict);
        
        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            let dataDictionary = JSON(response.result.value!)
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(response.result.error)")
                failureCallBack(response.error!)
                return
            }
            
            
            let header : Dictionary<AnyHashable,Any> = (response.response?.allHeaderFields)!
            
            if nil != header["Access-Token"] {
                MCASessionManager.sharedSessionManager.accessToken = header["Access-Token"] as! String?
            }
            if nil != header["Client"] {
                MCASessionManager.sharedSessionManager.client = header["Client"] as! String?
            }
            if nil != header["Uid"] {
                MCASessionManager.sharedSessionManager.uid = header["Uid"] as! String?
            }
            
        
            
            
            print(response)
            successCallBack(dataDictionary.dictionaryObject as Dictionary<String, AnyObject>!)
            return
        }
    }

    
    func getRequest(requestParam: Dictionary<String , Any>,
                    endPoint: String?,
                     successCallBack: @escaping (_ responseData: Any) -> Void,
                     failureCallBack: @escaping (_ error: Error) -> Void)
    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)
        var headersDict : Dictionary<String,String> = Dictionary()
        headersDict["Content-Type"] = "application/json ; charset=utf-8"
        headersDict["Accept"] = "application/json"
        if nil != MCASessionManager.sharedSessionManager.accessToken
        {
            headersDict["Access-Token"] = MCASessionManager.sharedSessionManager.accessToken
        }
        if nil != MCASessionManager.sharedSessionManager.client
        {
            headersDict["Client"] = MCASessionManager.sharedSessionManager.client
        }
        if nil != MCASessionManager.sharedSessionManager.uid
        {
            headersDict["Uid"] = MCASessionManager.sharedSessionManager.uid
        }
        

        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .get, parameters: requestParam, encoding: URLEncoding.queryString, headers: headersDict);

        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            

            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(response.result.error)")
                failureCallBack(response.error!)
                return
            }
            
            let dataDictionary = JSON(response.result.value!)
            print(response)
            let header : Dictionary<AnyHashable,Any> = (response.response?.allHeaderFields)!
            
            if nil != header["Access-Token"] {
                MCASessionManager.sharedSessionManager.accessToken = header["Access-Token"] as! String?
            }
            if nil != header["Client"] {
                MCASessionManager.sharedSessionManager.client = header["Client"] as! String?
            }
            if nil != header["Uid"] {
                MCASessionManager.sharedSessionManager.uid = header["Uid"] as! String?
            }
            

            successCallBack(dataDictionary.dictionaryObject as Dictionary<String, AnyObject>!)
            return
        }
  
        
    }

    
    func patchRequest(requestParam: Dictionary<String , Any>,
                      endPoint: String?,
                      successCallBack: @escaping (_ responseData: Dictionary<String , AnyObject>) -> Void,
                      failureCallBack: @escaping (_ error: Error) -> Void)

    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)
        var headersDict : Dictionary<String,String> = Dictionary()
        headersDict["Content-Type"] = "application/json;charset=utf-8"
        headersDict["Accept"] = "application/json"
        if nil != MCASessionManager.sharedSessionManager.accessToken
        {
            headersDict["Access-Token"] = MCASessionManager.sharedSessionManager.accessToken
        }
        if nil != MCASessionManager.sharedSessionManager.client
        {
            headersDict["Client"] = MCASessionManager.sharedSessionManager.client
        }
        if nil != MCASessionManager.sharedSessionManager.uid
        {
            headersDict["Uid"] = MCASessionManager.sharedSessionManager.uid
        }
        

        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .patch, parameters: requestParam, encoding: URLEncoding.queryString, headers: headersDict);
        
        apiRequest.validate()
        apiRequest.responseJSON { (response) in
           
            

            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(response.result.error)")
                failureCallBack( response.error!)
                return
            }
            
            let dataDictionary = JSON(response.result.value!)

            print(response)
            let header : Dictionary<AnyHashable,Any> = (response.response?.allHeaderFields)!
            
            if nil != header["Access-Token"] {
                MCASessionManager.sharedSessionManager.accessToken = header["Access-Token"] as! String?
            }
            if nil != header["Client"] {
                MCASessionManager.sharedSessionManager.client = header["Client"] as! String?
            }
            if nil != header["Uid"] {
                MCASessionManager.sharedSessionManager.uid = header["Uid"] as! String?
            }
            successCallBack(dataDictionary.dictionaryObject as Dictionary<String, AnyObject>!)
            return
        }
       
    }
}
