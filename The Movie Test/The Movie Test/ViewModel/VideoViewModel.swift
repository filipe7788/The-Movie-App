//
//  VideoViewModel.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 25/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation
import RxCocoa

struct VideoViewModel {
  
    var videos = BehaviorRelay<[Video]>(value: [])
    var error = BehaviorRelay<String>(value: "")
    var sucesso = BehaviorRelay<String>(value: "")
    var loading = BehaviorRelay<Bool>(value: false)
    
    func getVideos(idFilme: Int){
        loading.accept(true)
        REST.getVideo(idFilme: idFilme, completionHandler:{ videos in
            self.videos.accept(videos ?? [Video]())
        }, errorHandler: {
            self.error.accept("Erro Ocorrido")
        })
        loading.accept(false)
    }

}
