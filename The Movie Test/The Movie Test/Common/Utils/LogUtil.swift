//
//  LogUtil.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit

class LogUtil: NSObject {
    
    
    static func info(msg: String) {
        print("LogUtil - INFO - \(msg)")
    }
    
    static func error(msg: String) {
        print("LogUtil - ERROR - \(msg)")
    }
}
