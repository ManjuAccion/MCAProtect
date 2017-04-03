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

    
    func readAPIHeaders1() -> Dictionary<String,String>
    {
        var headersDict : Dictionary<String,String> = Dictionary()
        
        headersDict["Content-Type"] = "application/json ; charset=utf-8"
        headersDict["Accept"] = "application/json"
        if nil != MCASessionManager.sharedSessionManager.accessToken
        {
            headersDict["access-token"] = MCASessionManager.sharedSessionManager.accessToken
        }
        if nil != MCASessionManager.sharedSessionManager.client
        {
            headersDict["client"] = MCASessionManager.sharedSessionManager.client
        }
        if nil != MCASessionManager.sharedSessionManager.uid
        {
            headersDict["uid"] = MCASessionManager.sharedSessionManager.uid
        }
        
        return headersDict
    }
    
    
    func readAPIHeaders() -> Dictionary<String,String>
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
        
        return headersDict
    }
    
    
    func setAPIHeaders(header : Dictionary<AnyHashable,Any>)
    {
        if nil != header["access-token"] {
            MCASessionManager.sharedSessionManager.accessToken = header["access-token"] as! String?
        }
        if nil != header["client"] {
            MCASessionManager.sharedSessionManager.client = header["client"] as! String?
        }
        if nil != header["uid"] {
            MCASessionManager.sharedSessionManager.uid = header["uid"] as! String?
        }
    }

    
    
    
    
    func postRequest(requestParam: Dictionary<String , Any>,
                     endPoint: String?,
                successCallBack: @escaping (_ responseData: JSON) -> Void,
                failureCallBack: @escaping (_ error: Error) -> Void)
    {

        let headersDict = self.readAPIHeaders();
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)
        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .post, parameters: requestParam, encoding: URLEncoding.queryString, headers: headersDict);
        
        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(response.result.error)")
                failureCallBack(response.error!)
                return
            }
            
            
            let dataDictionary = JSON(response.result.value!)
            let header : Dictionary<AnyHashable,Any> = (response.response?.allHeaderFields)!
            
            self.setAPIHeaders(header: header);
        
            print(response)
            successCallBack(dataDictionary)
            return
        }
    }

    
    

    
    func getRequest(requestParam: Dictionary<String , Any>,
                     endPoint: String?,
                     successCallBack: @escaping (_ responseData: Dictionary<String , AnyObject>) -> Void,
                     failureCallBack: @escaping (_ error: Error) -> Void)
    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)

        
        let headersDict = self.readAPIHeaders();

        
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
            
            self.setAPIHeaders(header: header);
            

            successCallBack(dataDictionary.dictionaryObject as Dictionary<String, AnyObject>!)
            return
        }
  
        
    }

    
    func patchRequest(requestParam: Dictionary<String , Any>,
                      endPoint: String?,
                      successCallBack: @escaping (_ responseData: JSON) -> Void,
                      failureCallBack: @escaping (_ error: Error) -> Void)

    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)
        
        
        let headersDict = self.readAPIHeaders1();
        

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
            
            self.setAPIHeaders(header: header);
            successCallBack(dataDictionary)
            return
        }
       
    }
    
    func deleteRequest(requestParam: Dictionary<String , Any>,
                      endPoint: String?,
                      successCallBack: @escaping (_ responseData: JSON) -> Void,
                      failureCallBack: @escaping (_ error: Error) -> Void)
        
    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)
        
        
        let headersDict = self.readAPIHeaders1();
        
        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .delete, parameters: requestParam, encoding: URLEncoding.queryString, headers: headersDict);
        
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
            
            self.setAPIHeaders(header: header);
            successCallBack(dataDictionary)
            return
        }
        
    }
    
    
}
