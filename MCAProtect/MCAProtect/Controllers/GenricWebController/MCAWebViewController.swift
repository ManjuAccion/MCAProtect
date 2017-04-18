//
//  MCAWebViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCAWebViewController: MCABaseViewController {
    var nameTitle : String?
    var docUrl : URL!
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = nameTitle
        let requestObj = URLRequest(url: docUrl)
        webView.loadRequest(requestObj)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
