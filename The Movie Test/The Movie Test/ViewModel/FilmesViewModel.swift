//
//  PopularesViewModel.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 16/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation
import RxCocoa

struct FilmesViewModel {
    
    var filmes = BehaviorRelay<[Movie]>(value: [])
    var error = BehaviorRelay<String>(value: "")
    var sucesso = BehaviorRelay<String>(value: "")
    var loading = BehaviorRelay<Bool>(value: false)
    
    func getFilmes(url: EnumURL){
        loading.accept(true)
        REST.getFilmes(urlEnum: url, completionHandler: { RequestMovies in
            self.filmes.accept(RequestMovies ?? [Movie]())
            self.loading.accept(false)
            self.sucesso.accept("Filme Adcionado a lista")
        }, errorHandler: {
            self.loading.accept(false)
            self.error.accept("Erro na requisição")
        })
    }
    
    func getFoto(url: String)-> UIImage {
        let url = URL(string: "https://image.tmdb.org/t/p/w500/"+url)
        let data = try? Data(contentsOf: url!)
        return UIImage(data: data ?? Data()) ?? UIImage()
    }
    
    func getVideo(idFilme: Int, completion: @escaping (URL?) -> ()){
        loading.accept(true)
        REST.getVideo(idFilme: idFilme, completionHandler:{ url in completion(url)}, errorHandler: { })
        loading.accept(false)
    }
}
