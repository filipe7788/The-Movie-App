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
            case .failure(let value):
                errorHandler()
            }
        }
    }
}
