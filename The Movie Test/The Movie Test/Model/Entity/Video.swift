//
//  Video.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 02/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation
import ObjectMapper

class Video: Mappable{
    var key:    String?
    var name:   String?
    var site:   String?
    init() { }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
    }
    
    
}
