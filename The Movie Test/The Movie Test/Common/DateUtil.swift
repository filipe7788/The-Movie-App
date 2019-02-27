//
//  DateUtil.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 27/02/19.
//  Copyright © 2019 Filipe Cruz. All rights reserved.
//

import Foundation

class DateUtil {
    static func convertDateString(dateString : String!) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: date!)
    }
}
