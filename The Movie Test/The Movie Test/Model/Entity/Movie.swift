//
//  Movie.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation
import ObjectMapper


class Movie: Mappable{
    
    var Nome: String?
    var Descricao: String?
    var DataLancamento: Date?
    var MediaNota: Int?
    var Banner: String?
    
    required init?(map: Map) {  }
    
    func mapping(map: Map) {
        Nome <- map["name"]
        Descricao <- map["overview"]
        DataLancamento <- map["release_date"]
        MediaNota <- map["vote_average"]
        Banner <- map["backdrop_path"]
    }
    
    
}
