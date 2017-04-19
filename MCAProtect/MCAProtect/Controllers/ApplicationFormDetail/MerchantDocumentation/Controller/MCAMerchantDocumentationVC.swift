//
//  MCAMerchantDocumentationVC.swift
//  MCAProtect
//
//  Created by Sarath NS on 3/1/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAMerchantDocumentationVC: MCABaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var parentDelegate: MCAApplicationFormVC!
    var merchantDocumentation : MCAMerchantDocumentation!
    var loanApplication : MCALoanApplication!
    var merchantDocumentationArray : [MCAMerchantDocumentation]!
    var doctUrl : URL!
    @IBOutlet weak var webViewLoadingIndicator: UIActivityIndicatorView!

    @IBOutlet weak var popUpView : UIView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var transparentImageView : UIImageView!

    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        merchantDocumentationArray = loanApplication.merchantDocumentation
        self.title = "Merchant Documentation"
        tableView.register(UINib(nibName: "MCAMerchantDocumentationTVCell", bundle: Bundle.main), forCellReuseIdentifier: CellIdentifiers.MCAMerchantDocumentationTVCell)
        tableView.tableFooterView = UIView()
        
        popUpView.alpha = 0.0
        transparentImageView.alpha = 0.0
        webViewLoadingIndicator.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return merchantDocumentationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MCAMerchantDocumentationTVCell, for: indexPath) as! MCAMerchantDocumentationTVCell
        cell.parentDelegate = self
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        merchantDocumentation = merchantDocumentationArray[indexPath.row]
        cell.setMerchantDocumentation(merchantDocumentation: merchantDocumentation)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 96.0
    }

    
    @IBAction func nextButton()
    {
        
        
        parentDelegate.goToNext()
    }
    
    @IBAction func previousButton()
    {
        
        parentDelegate.goToPrevious()
        
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
    
    @IBAction func closePopUpView()
    {
        removeAnimate()
        
    }
    
    
    public func webViewDidStartLoad(_ webView: UIWebView){
        
        webViewLoadingIndicator.isHidden = false
        webViewLoadingIndicator.startAnimating()
    }
    
    public func webViewDidFinishLoad(_ webView: UIWebView){
        webViewLoadingIndicator.isHidden = true
        webViewLoadingIndicator.stopAnimating()
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
        webViewLoadingIndicator.stopAnimating()
        webViewLoadingIndicator.isHidden = true
    }
    
    


}
