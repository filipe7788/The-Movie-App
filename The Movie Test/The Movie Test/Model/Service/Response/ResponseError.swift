//
//  ResponseError.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation
import ObjectMapper

class ResponseError: Mappable {
    
    var error: String?
    var errorCode: Int?
    
    required init?(map: Map) {
        
    }
    
    required init?(error: String) {
        self.error = error
    }
    
    // Mappable
    func mapping(map: Map) {
        errorCode <- map["error"]
        error    <- map["error_description"]
    }
    
}
