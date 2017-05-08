//
//  MCANotificationViewController.swift
//  MCAProtect
//
//  Created by Accion Labs on 08/05/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCANotificationViewController: MCABaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    var notificationData : MCANotificationData!
    var dataSource = [MCANotificationData]()
    @IBOutlet weak var tableView: UITableView!



    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifications"
        
        tableView.register(UINib(nibName: "MCANotificationTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "MCANotificationTableViewCell")
        tableView.tableFooterView = UIView()

        
        fetchAllNotifications()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func fetchAllNotifications()
    {
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()
        
            
       
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:MCAAPIEndPoints.BrokerFetchAllNotificationsEndPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                
                if let items = response["notifications"].array
                {
                    for item in items {
                        self.notificationData = MCANotificationData(data:item)
                        self.dataSource.append(self.notificationData)
                    }
                }

              self.tableView.reloadData()
                
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Unable to fetch Notifications", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
        
  
        
        
    }
    
    
    //MARK: - Table View Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier:"MCANotificationTableViewCell", for: indexPath) as! MCANotificationTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        let notification  = dataSource[indexPath.row]
        cell.dataLabel.text = notification.dataSent
        cell.dateLabel.text = MCAUtilities.getFormmattedDate(dateString: notification.updatedDate)
        
        if(notification.readStatus == 0)
        {
          cell.imageView?.isHidden = false
            
        }
        else{
            cell.imageView?.isHidden = true
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notification  = dataSource[indexPath.row]
        updateNotificationStatus(notification: notification)
        }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60.0
    }
    
    func updateNotificationStatus( notification: MCANotificationData)
    {
        if self.checkNetworkConnection() == false {
            return
        }
        
        self.showActivityIndicator()
        
        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerUpdateNotificationStatusEndPoint);
        endPoint.append("/\(notification.notificationID!)");
        
        
        MCAWebServiceManager.sharedWebServiceManager.putRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                
                self.stopActivityIndicator()
                
                               
                self.tableView.reloadData()
                
        },
              failureCallBack: { (error : Error) in
                
                self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Unable to update", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
        

        
        
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
