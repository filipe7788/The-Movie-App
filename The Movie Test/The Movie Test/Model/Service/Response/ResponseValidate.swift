//
//  ResponseValidate.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseValidate: Mappable {
    
    var status: String?
    var mensagem: String?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        var statusInt: Int?
        statusInt <- map["status"]
        var statusStr: String?
        statusStr <- map["status"]
        var message: String?
        message <- map["message"]
        
        status = statusStr ?? statusInt?.description
        if let message = message {
            mensagem = message
        } else {
            mensagem <- map["mensagem"]
        }
    }
    
}
