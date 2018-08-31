//
//  HTTPCodes.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation

enum HTTPCodes: Int {
    
    case noCode = 0
    case OK = 200
    case created = 201
    case noContent = 204
    case notFound = 404
    case locked = 423
    case notAllowed = 405
}

func ==(lhs: Int, rhs: HTTPCodes) -> Bool {
    return lhs == rhs.rawValue
}

func ==(lhs: String, rhs: HTTPCodes) -> Bool {
    return lhs == String(rhs.rawValue)
}
