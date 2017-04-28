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

    
    
    func readAPIHeaders() -> Dictionary<String,String>
    {
        var headersDict : Dictionary<String,String> = Dictionary()
        
        headersDict["Content-Type"] = "application/json;charset=utf-8"
        headersDict["Accept"] = "application/json"
        headersDict["User-Agent"] = "MCAPIos"
        if let value = MCASessionManager.sharedSessionManager.accessToken
        {
            headersDict["access-token"] = value
        }
        if let value = MCASessionManager.sharedSessionManager.client
        {
            headersDict["client"] = value
        }
        if let value = MCASessionManager.sharedSessionManager.uid
        {
            headersDict["uid"] = value
        }
        
        return headersDict
    }
    
    
    func setAPIHeaders(header : Dictionary<AnyHashable,Any>)
    {
        if let value =  header["access-token"] {
            MCASessionManager.sharedSessionManager.accessToken = value as? String
        }
        if let value =  header["client"] {
            MCASessionManager.sharedSessionManager.client = value as? String
        }
        if let value = header["uid"] {
            MCASessionManager.sharedSessionManager.uid = value as? String
        }
    }
    
    func loginRequest(requestParam: Dictionary<String , Any>,
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
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
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
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                failureCallBack(response.error!)
                return
            }
            
            let dataDictionary = JSON(response.result.value!)
            
                           
            print(response)
            successCallBack(dataDictionary)
            return
        }
    }

    
    

    
    func getRequest(requestParam: Dictionary<String , Any>,
                     endPoint: String?,
                     successCallBack: @escaping (_ responseData: JSON) -> Void,
                     failureCallBack: @escaping (_ error: Error) -> Void)
    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)

        
        let headersDict = self.readAPIHeaders();

        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .get, parameters: requestParam, encoding: URLEncoding.queryString, headers: headersDict);

        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            

            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                failureCallBack(response.error!)
                return
            }
            
            let dataDictionary = JSON(response.result.value!)
            print(response)
            

            successCallBack(dataDictionary)
            return
        }
  
        
    }
    
    func putRequest(requestParam: Dictionary<String , Any>,
                      endPoint: String?,
                      successCallBack: @escaping (_ responseData: JSON) -> Void,
                      failureCallBack: @escaping (_ error: Error) -> Void)
        
    {
        
        var completeURL : String = baseURL
        completeURL.append(endPoint!)
        
        
        let headersDict = self.readAPIHeaders();
        
        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .put, parameters: requestParam, encoding: URLEncoding.queryString, headers: headersDict);
        
        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            
            
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                failureCallBack( response.error!)
                return
            }
            
            let dataDictionary = JSON(response.result.value!)
            
            print(response)
            
            successCallBack(dataDictionary)
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
        
        
        let headersDict = self.readAPIHeaders();
        

        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .patch, parameters: requestParam, encoding: URLEncoding.queryString, headers: headersDict);
        
        apiRequest.validate()
        apiRequest.responseJSON { (response) in
           
            

            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                failureCallBack( response.error!)
                return
            }
            
            let dataDictionary = JSON(response.result.value!)

            print(response)

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
        
        
        let headersDict = self.readAPIHeaders();
        
        
        let apiRequest =  Alamofire.request(URL(string: completeURL)!, method: .delete, parameters: requestParam, encoding: URLEncoding.queryString, headers: headersDict);
        
        apiRequest.validate()
        apiRequest.responseJSON { (response) in
            
            
            
            guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                failureCallBack( response.error!)
                return
            }
            
            let dataDictionary = JSON(response.result.value!)
            
            print(response)
            
            successCallBack(dataDictionary)
            return
        }
        
    }
    
    func uploadImageRequest(requestParam: Dictionary<String , Any>,
                            endPoint: String?,imageData: Data,
                     successCallBack: @escaping (_ responseData: JSON) -> Void,
                     failureCallBack: @escaping (_ error: Error) -> Void)
    {
        var completeURL : String = baseURL
        completeURL.append("/brokers/upload_profile_image")
        let url = NSURL(string: completeURL)
        var urlRequest = URLRequest(url: url as! URL)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
        

     Alamofire.upload(multipartFormData: { (MultipartFormData) in
        MultipartFormData.append(imageData,
                                 withName: "file",
                                 fileName: "image.jpg",
                                 mimeType: "image/jpeg")
        }, with: urlRequest) { (result) in
        switch result {
        case .success(let upload, _, _):
            
            upload.uploadProgress(closure: { (progress) in
                print (" progress is \(progress)")
            })
            
            upload.responseJSON { response in
                print (response.result)
                let dataDictionary = JSON(response.result.value!)
                successCallBack(dataDictionary)
                return

            }
            
        case .failure(let encodingError):
            print (encodingError)
        }
        
        }

    }
}
