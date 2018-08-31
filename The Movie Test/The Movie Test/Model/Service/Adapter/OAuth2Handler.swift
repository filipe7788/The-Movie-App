//
//  OAuth2Handler.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import Foundation

import UIKit
import Alamofire

class OAuth2Handler: RequestAdapter, RequestRetrier {
    
    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        
    }
    
    private typealias RefreshCompletion = (_ succeeded: Bool, _ accessToken: String?, _ refreshToken: String?) -> Void
    
    private var requestPedding: [Request] = []
    
    private let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return SessionManager(configuration: configuration)
    }()
    
    private let lock = NSLock()
    
    private var baseURLString: String
    private var accessToken: String
    
    private var isRefreshing = false
    private var requestsToRetry: [RequestRetryCompletion] = []
    
    // MARK: - Initialization
    public init(baseURLString: String, accessToken: String) {
        self.baseURLString = baseURLString
        self.accessToken = accessToken
    }
    
    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        if (urlRequest.url != nil && urlRequest.url!.absoluteString.hasPrefix(baseURLString)){
            LogUtil.info(msg: "Passando Token \(accessToken) para requisição")
            LogUtil.info(msg: urlRequest.url?.absoluteString ?? "")
            
            var urlRequest = urlRequest
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            if let method =  urlRequest.httpMethod, !(urlRequest.allHTTPHeaderFields?.contains { key, value in key == "Content-Type" } ?? false) {
                if ("GET" == method) {
                    urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                } else {
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
            }
            LogUtil.info(msg: "Request - \(urlRequest)")
            
            return urlRequest
        }
        var urlRequest = urlRequest
        urlRequest.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        return urlRequest
    }
    
}
