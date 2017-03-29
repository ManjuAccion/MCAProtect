//
//  MCASessionManager.swift
//  MCAProtect
//
//  Created by Manjunath on 28/03/17.
//  Copyright © 2017 Accionlabs. All rights reserved.
//

import UIKit

class MCASessionManager: NSObject {
    
    // Can't init is singleton
    private override init() {}
    
    //MARK: Shared Instance
    
    static let sharedSessionManager: MCASessionManager = MCASessionManager()
    
    
}
