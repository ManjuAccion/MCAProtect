//
//  MCAWebServiceManager.swift
//  MCAProtect
//
//  Created by Manjunath on 28/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import Alamofire

class MCAWebServiceManager: NSObject
{

    // Can't init is singleton
    private override init() {}
    
    //MARK: Shared Instance
    
    static let sharedWebServiceManager: MCAWebServiceManager = MCAWebServiceManager()

    
    
    
    func postRequest(requestParam: Dictionary<String , Any>,
                     endPoint: String?,
                successCallBack: @escaping (_ responseData: Any) -> Void,
                failureCallBack: @escaping (_ responseData: Any , _ error: Error) -> Void)
    {
            
        let dataRequest =  Alamofire.request(URL(string: "https://broker-dev.mcaprotect.org/api/broker/sign_in.json")!, method: .post, parameters: requestParam, encoding: URLEncoding.queryString, headers: ["Content-Type":"application/json ; charset=utf-8","Accept":   "application/json"]);
        
        dataRequest.validate()
        dataRequest.responseJSON { (response) in
            
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

    
    func getRequest(requestParam: Dictionary<String , Any>,
                    endPoint: String,
                     successCallBack: @escaping (_ responseData: Any) -> Void,
                     failureCallBack: @escaping (_ responseData: Any , _ error: Error) -> Void)
    {
        
        let dataRequest =  Alamofire.request(URL(string: "http://localhost:5984/rooms/_all_docs")!, method: .get, parameters: requestParam, encoding: URLEncoding.default, headers: ["Content-Type":"application/json ; charset=utf-8","Accept":   "application/json"]);

        dataRequest.validate()
        dataRequest.responseJSON { (response) in
            
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
                      endPoint: String,
                    successCallBack: @escaping (_ responseData: Any) -> Void,
                    failureCallBack: @escaping (_ responseData: Any , _ error: Error) -> Void)
    {
        let dataRequest =  Alamofire.request(URL(string: "http://localhost:5984/rooms/_all_docs")!, method: .patch, parameters: requestParam, encoding: URLEncoding.default, headers: ["Content-Type":"application/json","Accept":   "application/json"]);
        
        dataRequest.validate()
        dataRequest.responseJSON { (response) in
            
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
