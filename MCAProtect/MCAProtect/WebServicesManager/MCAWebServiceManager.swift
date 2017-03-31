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
                failureCallBack: @escaping (_ responseData: Dictionary<String , AnyObject> , _ error: Error) -> Void)
    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)
        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .post, parameters: requestParam, encoding: URLEncoding.queryString, headers: ["Content-Type":"application/json ; charset=utf-8","Accept":   "application/json"]);
        
        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            let dataDictionary = JSON(response.result.value!)
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(response.result.error)")
                failureCallBack(dataDictionary.dictionaryObject as Dictionary<String, AnyObject>!, response.error!)
                return
            }
            
            
            
            
            print(response)
            successCallBack(dataDictionary.dictionaryObject as Dictionary<String, AnyObject>!)
            return
        }
    }

    
    func getRequest(requestParam: Dictionary<String , Any>,
                    endPoint: String?,
                     successCallBack: @escaping (_ responseData: Any) -> Void,
                     failureCallBack: @escaping (_ responseData: Any , _ error: Error) -> Void)
    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)

        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .get, parameters: requestParam, encoding: URLEncoding.default, headers: ["Content-Type":"application/json ; charset=utf-8","Accept":   "application/json"]);

        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(response.result.error)")
                failureCallBack(response, response.error!)
                return
            }
            
            print(response)
            successCallBack(response)
            return
        }
  
        
    }

    
    func patchRequest(requestParam: Dictionary<String , Any>,
                      endPoint: String?,
                    successCallBack: @escaping (_ responseData: Any) -> Void,
                    failureCallBack: @escaping (_ responseData: Any , _ error: Error) -> Void)
    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)

        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .patch, parameters: requestParam, encoding: URLEncoding.default, headers: ["Content-Type":"application/json","Accept":   "application/json"]);
        
        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(response.result.error)")
                failureCallBack(response, response.error!)
                return
            }
            
            print(response)
            successCallBack(response)
            return
        }
       
    }
}
