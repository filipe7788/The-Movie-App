//
//  BaseRest.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//


import Foundation
import Alamofire
import ObjectMapper

class BaseRest {
    
    static let statusValidate = ["0", "9"]
    
    static let encoding = JSONEncoding.default
    
    static var sessionManager: SessionManager {
        let session = Alamofire.SessionManager.default
        let oauthHandler = OAuth2Handler(
            baseURLString: "https://api.themoviedb.org/3/",
            accessToken: "2bae12ea6f75b14280cce8dc6ea5f242"
        )
        
        session.adapter = oauthHandler
        
        return session
    }
    
    
    
    static func handlerResultObject<T: BaseMappable>(completion: (T?) -> (), error: (ResponseError?) -> (), response: DataResponse<Any>) {
        if(response.response != nil && response.response!.statusCode == HTTPCodes.noContent) {
            completion(nil)
        } else if(response.result.isSuccess) {
            if let responseError = validateResponse(statusCode: response.response!.statusCode, result: response.result.value) {
                error(responseError)
            } else {
                completion(Mapper<T>().map(JSONObject: response.result.value))
            }
        } else {
            error(validateResponse(statusCode: response.response?.statusCode ?? 400, result: nil))
        }
    }
    
    static func handlerResultArray<T: BaseMappable>(completion: ([T]?) -> (), error: (ResponseError?) -> (), response: DataResponse<Any>) {
        if(response.response != nil && response.response!.statusCode == HTTPCodes.noContent) {
            completion([T]())
        } else if(response.result.isSuccess) {
            if let responseError = validateResponse(statusCode: response.response!.statusCode, result: response.result.value) {
                error(responseError)
            } else {
                completion(Mapper<T>().mapArray(JSONObject: response.result.value))
            }
        } else {
            error(validateResponse(statusCode: response.response?.statusCode ?? 400, result: nil))
        }
    }
    
    static func validateResponse(statusCode: Int, result: Any?) -> ResponseError? {
        return (statusCode == HTTPCodes.OK || statusCode == HTTPCodes.created || statusCode == HTTPCodes.noContent) ? nil : (result == nil ? ResponseError(error: "ocorreu_erro") : Mapper<ResponseError>().map(JSONObject: result))
    }
}
