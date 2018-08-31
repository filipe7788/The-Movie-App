//
//  Endpoints.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation


struct API {
    static let baseUrl = ""
}

protocol Endpoint {
    var path: String { get }
}

extension Endpoint {
    var url: String { get { return "\(API.baseUrl)\(path)" } }
}

enum Endpoints{
    
}
