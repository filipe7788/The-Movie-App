//
//  EnumURL.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 02/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
}

enum EnumURL: Endpoint{
    
    case Pesquisar(String)
    case EmCartaz
    case Populares
    case MelhoresNotas
    case Video(Int)
    case Filme(Int)
    
    public var path: String {
        switch self {
        case .Pesquisar(let nome): return "search/movie?&query=\(nome)"
        case .EmCartaz:  return "movie/now_playing?"
        case .Populares: return "movie/popular?"
        case .MelhoresNotas: return "movie/top_rated?"
        case .Video(let video): return "movie/\(video)/videos?"
        case .Filme(let filme): return "movie/\(filme)?"
        }
    }
}
