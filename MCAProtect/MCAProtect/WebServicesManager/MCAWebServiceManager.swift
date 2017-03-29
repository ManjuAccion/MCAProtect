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

    
    
    
    
    
    
    
    
    
    
    
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        Alamofire.upload(
//            multipartFormData: { multipartFormData in
//                multipartFormData.append(imageData,
//                                         withName: "imagefile",
//                                         fileName: "image.jpg",
//                                         mimeType: "image/jpeg")
//        },
//            with: ImaggaRouter.content,
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.uploadProgress { progress in
//                        progressCompletion(Float(progress.fractionCompleted))
//                    }
//                    upload.validate()
//                    upload.responseJSON { response in
//                        guard response.result.isSuccess else {
//                            print("Error while uploading file: \(response.result.error)")
//                            completion([String](), [PhotoColor]())
//                            return
//                        }
//                        
//                        guard let responseJSON = response.result.value as? [String: Any],
//                            let uploadedFiles = responseJSON["uploaded"] as? [Any],
//                            let firstFile = uploadedFiles.first as? [String: Any],
//                            let firstFileID = firstFile["id"] as? String else {
//                                print("Invalid information received from service")
//                                completion([String](), [PhotoColor]())
//                                return
//                        }
//                        
//                        print("Content uploaded with ID: \(firstFileID)")
//                        
//                        self.downloadTags(contentID: firstFileID) { tags in
//                            self.downloadColors(contentID: firstFileID) { colors in
//                                completion(tags, colors)
//                            }
//                        }
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                }
//        }
//        )
//    }
//    
////    public func postRequest(requestParams: Dictionary<String , Any>)
////    {
////        
////        
////    }
}
