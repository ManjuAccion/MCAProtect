//
//  MCAMASubmitStipulationsVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/9/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAMASubmitStipulationsVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, MCASubmitStipulationsCellDelegate,UIWebViewDelegate,MCASubmitStipulationsViewDelegate,MCAUploadDocumentsViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popUpView : UIView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var transparentImageView : UIImageView!
    @IBOutlet weak var webViewLoadingIndicator: UIActivityIndicatorView!

    
    var merchantApplicationDetail : MCAMerchantApplicationDetail!
    var dataSource : [JSON] = []
    var doctUrl : URL!
    var uploadDocumentView : MCAUploadDocumentsView!
    var documentURL : String!
    var uploadDocumentName : String!
    var documentDetails = [[String:String]]()


    //MARK: -View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MCASubmitStipulationsCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCASubmitStipulationsCell)
        self.title = merchantApplicationDetail.businessName
        popUpView.alpha = 0.0
        transparentImageView.alpha = 0.0
        webViewLoadingIndicator.isHidden = true
        getDocumentsList()
        documentURL = ""
        imagePicker?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDocumentsList()
    {
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()
        
        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerNeedMoreStipDocEndpoint);
        endPoint.append("/\(merchantApplicationDetail.applicationID!)");
        endPoint.append("/\(merchantApplicationDetail.acceptedFundingProgramID!)");
        
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                print("Success \(response)")
                let responseDcit = response.dictionaryValue;
                self.dataSource = (responseDcit["stipulations"]?.array)!
                
                self.tableView.reloadData()
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Dashboard update Failed", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
    }
    
    //MARK: - Table View DataSource functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCASubmitStipulationsCell) as! MCASubmitStipulationsCell
        cell.delegate = self
        cell.setSubmitStipulationsCell(documentDetail: dataSource[indexPath.row])
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    //MARK: - Table View Delegate functions
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = Bundle.main.loadNibNamed("MCASubmitStipulationsView", owner: self, options: nil)?[0] as! MCASubmitStipulationsView
        footerView.delegate = self
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func viewApplication(docUrl : URL)
    {
        doctUrl = docUrl
        showAnimate(docUrl: doctUrl)
    }
    
    func showAnimate(docUrl : URL!)
    {
        let requestObj = URLRequest(url: docUrl)
        webView.loadRequest(requestObj)
        
        self.popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.popUpView.alpha = 0.0
        self.transparentImageView.alpha = 1.0
        UIView.animate(withDuration: 0.25, animations: {
            self.popUpView.alpha = 1.0
            self.popUpView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func removeAnimate()
    {
        self.transparentImageView.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.popUpView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.popUpView.alpha = 0.0
        })
    }
    
    @IBAction func closePopUpView() {
        removeAnimate()
    }
    
    //MARK: - Webview Delegate Methods -
    
    func webViewDidStartLoad(_ webView: UIWebView){
        
        webViewLoadingIndicator.isHidden = false
        webViewLoadingIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView){
        webViewLoadingIndicator.isHidden = true
        webViewLoadingIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        webViewLoadingIndicator.stopAnimating()
        webViewLoadingIndicator.isHidden = true
    }
    
    func addMoreDocuments() {
        self.transparentImageView.alpha = 1.0
        uploadDocumentView = Bundle.main.loadNibNamed("MCAUploadDocumentsView", owner: self, options: nil)?[0] as! MCAUploadDocumentsView
        uploadDocumentView.delegate = self
        transparentImageView.addSubview(uploadDocumentView)
        transparentImageView.isUserInteractionEnabled = true
        
        let uploadDocumentViewCenterX = NSLayoutConstraint(item: uploadDocumentView,
                                                       attribute: .centerX,
                                                       relatedBy: .equal,
                                                       toItem: transparentImageView,
                                                       attribute: .centerX,
                                                       multiplier: 1.0,
                                                       constant: 0)
        
        let uploadDocumentViewCenterY = NSLayoutConstraint(item: uploadDocumentView,
                                                       attribute: .centerY,
                                                       relatedBy: .equal,
                                                       toItem: transparentImageView,
                                                       attribute: .centerY,
                                                       multiplier: 1.0,
                                                       constant: 0)
        
        let uploadDocumentViewWidth = NSLayoutConstraint(item: uploadDocumentView,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: transparentImageView,
                                                     attribute: .width,
                                                     multiplier: 0.8,
                                                     constant: 0)
        
        let uploadDocumentViewHeight = NSLayoutConstraint(item: uploadDocumentView,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: transparentImageView,
                                                      attribute: .height,
                                                      multiplier: 0.55,
                                                      constant: 0)
        
        uploadDocumentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([uploadDocumentViewCenterX,
                                     uploadDocumentViewCenterY,
                                     uploadDocumentViewWidth,
                                     uploadDocumentViewHeight])
    }
    
    //MARK:- MCAUploadDocumentsViewDelegate Methods -
    
    func cameraButtonTapped() {
        selectImageFromSource()
    }
    
    func uploadButtonTapped(documentName: String) {
        
        uploadDocumentName = documentName
        
        if documentName.isEmpty {
            print("Document Name missing")
        }
        else if documentURL.isEmpty {
            print("Docmemt URL Missing")
        }
        else {
            addStipluations()
        }
    }
        
    override func updateImageView(imageURL : String) {
        documentURL = imageURL
        self.uploadDocumentView.imageView.contentMode = .scaleAspectFit
        self.uploadDocumentView.imageView.setShowActivityIndicator(true)
        self.uploadDocumentView.imageView.setIndicatorStyle(.gray)
        self.uploadDocumentView.imageView.sd_setImage(with: URL(string : imageURL))

    }
    
    func addStipluations()
    {
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()
        
        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerAddStipulationsEndPoint);
        endPoint.append("/\(merchantApplicationDetail.applicationID!)");
        endPoint.append("/\(merchantApplicationDetail.acceptedFundingProgramID!)");
        
        
        var paramDict = Dictionary<String , Any>()
        
        let dict : [String:String] = ["doc_name":uploadDocumentName,"doc_url":documentURL]
        documentDetails.append(dict)
        
        paramDict["doc_details"] = documentDetails

        
        MCAWebServiceManager.sharedWebServiceManager.postRequest(requestParam:paramDict,
                                                                 endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                self.stopActivityIndicator()
                self.uploadDocumentView.removeFromSuperview()
                self.transparentImageView.alpha = 0
                self.getDocumentsList()
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Unable to upload documents", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
    }


  }
