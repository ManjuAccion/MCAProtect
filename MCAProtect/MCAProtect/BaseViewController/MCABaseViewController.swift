//
//  MCABaseViewController.swift
//  MCAProtect
//
//  Created by Manjunath on 07/02/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import MessageUI

class MCABaseViewController: UIViewController,MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("---Controller====>//",self.description)
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated);
        self.view.setNeedsLayout();
    }


    @IBAction func backButtonPressed (_ : Any)
    {
        self.navigationController?.popViewController(animated: true);
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

    public func emailButtonTapped()
    {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["halen@MCAProtect.com"])
                mail.setMessageBody("", isHTML: true)
                
                present(mail, animated: true)
            } else {
                // show failure alert
            }
        }
        
        func mailComposeController(_ controller:MFMailComposeViewController , didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        
        
    }
    
    public func callButtonTapped()
    {
        let alertViewController = UIAlertController(title : "", message : "447415554422", preferredStyle : .alert)
        alertViewController.view.tintColor = ColorConstants.red
        alertViewController.addAction(UIAlertAction(title : "Cancel" , style : .default , handler : nil))
        
        alertViewController.addAction(UIAlertAction(title : "Call" , style : .default , handler : { action in
            
            if let url = NSURL(string: "tel://447415554422"), UIApplication.shared.canOpenURL(url as URL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open((url as URL),  options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url as URL)
                }
            }
            
        }))

       
        present(alertViewController, animated: true , completion: nil)

        
        
    }

}

extension UIViewController {
    
    func presentAlertWithTitle(title: String, message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) in print("Youve pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


