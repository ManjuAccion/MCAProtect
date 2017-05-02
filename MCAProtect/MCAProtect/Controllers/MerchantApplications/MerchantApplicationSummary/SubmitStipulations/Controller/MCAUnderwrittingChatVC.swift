//
//  MCAUnderwrittingChatVC.swift
//  MCAProtect
//
//  Created by Accion Labs on 30/04/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit
import SwiftyJSON

class MCAUnderwrittingChatVC: MCABaseViewController,UITextViewDelegate {
    @IBOutlet weak var   textView : UITextView!
    
    
    var selectedImage : UIImage?
    var lastChatBubbleY: CGFloat = 10.0
    var internalPadding: CGFloat = 60.0
    var lastMessageType: BubbleDataType?
    var applicationId       : Int!
    var lendingProgramId       : Int!
    var underWritingChatData : MCAUnderWritingChatData!
    var matchedFundingProgramList = [MCAUnderWritingChatData]()



    @IBOutlet weak var   txtheightconstraints : NSLayoutConstraint!
    @IBOutlet weak var buttomLayoutConstraint  : NSLayoutConstraint!


    @IBOutlet weak var messageCointainerScroll: UIScrollView!



    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let chatBubbleData1 = MCAChatBubbleData(text: "Hey !!!!have a look on that....", image:UIImage(named: "chatImage1.jpg"), date: Date(), type: .mine)
        addChatBubble(chatBubbleData1)
        
        let chatBubbleData2 = MCAChatBubbleData(text: "Nice.... what about this one", image:UIImage(named: "chatImage3.jpg"), date: Date(), type: .opponent)
        addChatBubble(chatBubbleData2)
        
        let chatBubbleData3 = MCAChatBubbleData(text: "Great Bro....!!!", image:nil, date: Date(), type: .mine)
        addChatBubble(chatBubbleData3)
        */
        
        getUnderWrittingChatList()
        textView.layer.cornerRadius = textView.frame.height/2

        
        self.messageCointainerScroll.contentSize = CGSize(width: messageCointainerScroll.frame.width, height: lastChatBubbleY + internalPadding)
        
        self.addKeyboardNotifications()
        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getUnderWrittingChatList() {
        
        if self.checkNetworkConnection() == false
        {
            return
        }
        
      self.showActivityIndicator()
        
        
        var endPoint = String()
        endPoint.append(MCAAPIEndPoints.BrokerUnderWrittingChatAPIEndpoint);
        endPoint.append("/\(applicationId!)");
        endPoint.append("/\(lendingProgramId!)");
        
        
        MCAWebServiceManager.sharedWebServiceManager.getRequest(requestParam:[:],
                                                                endPoint:endPoint
            , successCallBack:{ (response : JSON) in
                
                print("Success \(response)")
                self.stopActivityIndicator()
                
                let messageData = response["data"]
                
                let messageArray =  messageData.arrayValue
                
                
                for item in messageArray {
                    self.underWritingChatData = MCAUnderWritingChatData(underWritingChatData:item)
                    self.matchedFundingProgramList.append(self.underWritingChatData)
                }
                
             
                for item in  self.matchedFundingProgramList
                {
                    if item.userType == "Broker"{
                        
                        let chatBubbleData = MCAChatBubbleData(text:item.messageText, image:nil, date: MCAUtilities.getDateFromString(dateString: item.createdDate), type: .mine,profileImageUrl:item.userImageUrl)
                    self.addChatBubble(chatBubbleData)
                    }
                    else
                    {
                        let chatBubbleData = MCAChatBubbleData(text:item.messageText, image:nil, date: MCAUtilities.getDateFromString(dateString: item.createdDate), type: .opponent,profileImageUrl:item.userImageUrl)
                        self.addChatBubble(chatBubbleData)
                        
                    }
                    
                }
             
                
        },
              failureCallBack: { (error : Error) in
                
            self.stopActivityIndicator()
                print("Failure \(error)")
                let alertViewController = UIAlertController(title : "MCAP", message : "Chat update Failed", preferredStyle : .alert)
                alertViewController.addAction(UIAlertAction(title : "OK" , style : .default , handler : nil))
                self.present(alertViewController, animated: true , completion: nil)
                
        })
        
        
    }
    

    
    func addRandomTypeChatBubble() {
        let bubbleData = MCAChatBubbleData(text: textView.text, image: selectedImage, date: Date(), type: BubbleDataType.mine ,profileImageUrl:underWritingChatData.userImageUrl)
        addChatBubble(bubbleData)
    }
    
    @IBAction func sendButtonClicked(_ sender: AnyObject) {
        self.addRandomTypeChatBubble()
        textView.resignFirstResponder()
    }

    
    
    func addChatBubble(_ data: MCAChatBubbleData) {
        
        let padding:CGFloat = lastMessageType == data.type ? internalPadding/3.0 :  internalPadding
        let chatBubble = MCAChatBubble(data: data, startY:lastChatBubbleY + padding)
        

        self.messageCointainerScroll.addSubview(chatBubble)
        lastChatBubbleY = chatBubble.frame.maxY
    
        self.messageCointainerScroll.contentSize = CGSize(width: messageCointainerScroll.frame.width, height: lastChatBubbleY + internalPadding)
        self.moveToLastMessage()
        lastMessageType = data.type
        textView.text = ""
        self.txtheightconstraints.constant = 30.0;

      //  sendButton.isEnabled = false
    }
    
    func moveToLastMessage() {
        
        if messageCointainerScroll.contentSize.height > messageCointainerScroll.frame.height {
            let contentOffSet = CGPoint(x: 0.0, y: messageCointainerScroll.contentSize.height - messageCointainerScroll.frame.height)
            self.messageCointainerScroll.setContentOffset(contentOffSet, animated: true)
        }
    }

    func getRandomChatDataType() -> BubbleDataType {
        return BubbleDataType(rawValue: Int(arc4random() % 2))!
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        var newFrame = textView.frame;
        newFrame.size = CGSize.init(width:CGFloat(fmaxf(Float(newSize.width), Float(fixedWidth))), height: newSize.height)
        NSLog("this is updating height%@",NSStringFromCGSize(newFrame.size));
        
        UIView .animate(withDuration: 0.2) {
            self.txtheightconstraints.constant = newFrame.size.height;
            
        }
        
    }
    // MARK:- Notification
    
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    

    func keyboardWillShow(_ notification: Notification) {
        var info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            //self.buttomLayoutConstraint = keyboardFrame.size.height
            self.buttomLayoutConstraint.constant = keyboardFrame.size.height
            
        }, completion: { (completed: Bool) -> Void in
            self.moveToLastMessage()
        })
    }
    
    func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 1.0, animations: { () -> Void in
            self.buttomLayoutConstraint.constant = 0.0
        }, completion: { (completed: Bool) -> Void in
            self.moveToLastMessage()
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
