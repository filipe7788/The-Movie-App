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
    
    var ID: Int?
    var Nome: String?
    var Descricao: String?
    var DataLancamento: String?
    var MediaNota: Int?
    var Banner: String?
    
    init() {  }
    
    required init?(map: Map) {  }
    
    func mapping(map: Map) {
        ID <- map["id"]
        Nome <- map["title"]
        Descricao <- map["overview"]
        DataLancamento <- map["release_date"]
        MediaNota <- map["vote_average"]
        Banner <- map["poster_path"]
    }
    
    
}
