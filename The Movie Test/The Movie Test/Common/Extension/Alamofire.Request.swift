//
//  Alamofire.Request.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.DataRequest {
    func responseDebugPrint() -> Self {
        return responseJSON() {
            response in
            if let  JSON = response.result.value,
                let JSONData = try? JSONSerialization.data(withJSONObject: JSON, options: .prettyPrinted),
                let prettyString = NSString(data: JSONData, encoding: String.Encoding.utf8.rawValue) {
                print(prettyString)
            } else if let error = response.result.error {
                print("Error Debug Print: \(error.localizedDescription)")
            }
        }
    }
}
