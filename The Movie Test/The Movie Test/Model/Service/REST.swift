//
//  EndPoints.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 14/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class REST {
    
    static func getFilmes(urlEnum: EnumURL,completionHandler: @escaping ([Movie]?) -> (), errorHandler: @escaping () -> ()) {            
        Alamofire.request(Constants.baseURL+urlEnum.path+Constants.api_key+Constants.endOfURL).responseArray(keyPath: "results") { (response: DataResponse<[Movie]>) in
            switch response.result {
            case .success(_):
                if let movies = response.result.value{
                    completionHandler(movies)
                }
            case .failure(_):
                errorHandler()
            }
        }
    }
    
    static func getSearch(urlEnum: EnumURL, completionHandler: @escaping ([Movie]?) -> (), errorHandler: @escaping () -> ()) {
        Alamofire.request(Constants.baseURL+urlEnum.path+Constants.api_key+Constants.endOfURL).responseArray(keyPath: "results") { (response: DataResponse<[Movie]>) in
            switch response.result {
            case .success( _):
                if let movies = response.result.value{
                    completionHandler(movies)
                }
            case .failure(_):
                errorHandler()
            }
        }
    }
    
    static func getVideo(idFilme: Int, completionHandler: @escaping (URL?) -> (), errorHandler: @escaping () -> ()){
        Alamofire.request(Constants.baseURL+EnumURL.Video(idFilme).path+Constants.api_key+Constants.endOfURL).responseArray(keyPath: "results") { (response: DataResponse<[Video]>) in
            switch response.result {
                case .success( _):
                    if response.result.value?.isEmpty == false{
                        completionHandler(URL(string: "http://youtube.com/embed/"+(response.result.value?[0].key)!))
                    }
                case .failure(_):
                     errorHandler()
            }
        }
    }
    
    static func getFilme(idFilme: Int, completionHandler: @escaping (ResMovie?) -> (), errorHandler: @escaping () -> ()){
        Alamofire.request(Constants.baseURL+EnumURL.Filme(idFilme).path+Constants.api_key+Constants.endOfURL).responseObject{ (response: DataResponse<ResMovie>) in
            switch response.result {
            case .success( _):
                if let movie = response.result.value{
                    completionHandler(movie)
                }
            case .failure(_):
                    errorHandler()
            }
        }
    }
}
