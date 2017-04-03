//
//  MCASessionManager.swift
//  MCAProtect
//
//  Created by Manjunath on 28/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASessionManager: NSObject {
    
    var accessToken: String?
    var client: String?
    var uid: String?
    
    var mcapUser : MCAUser!
    // Can't init is singleton
    private override init() {}
    
    //MARK: Shared Instance
    static let sharedSessionManager: MCASessionManager = MCASessionManager()
    
    
}
