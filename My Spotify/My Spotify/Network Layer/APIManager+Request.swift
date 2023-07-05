//
//  ApiManager+Request.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//

import Foundation
import Alamofire

enum RequestItemsType: Equatable {
    case authToken(code: String)
}

// MARK: Extensions
// MARK: EndPointType

extension RequestItemsType: EndPointType {
    
    // MARK: Vars & Lets

    var baseURL: String {
        switch self {
        case .authToken:
            return AppConstants.baseAuth
        }
    }
    
    var api: String {
        return AppConstants.api
    }
    
    var version: String {
        switch self {
        case .authToken:
            return ""
        }
    }
    
    var path: String {
        switch self {
        case .authToken:
            return "token"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .authToken:
            if let basicCredential =  "\(AppConstants.clientId):\(AppConstants.clientSecret)".data(using: .utf8)?.base64EncodedString() {
                return [
                    "Authorization": "Basic " + basicCredential
                ]
            } else {
                return []
            }
        }
    }
    
    var url: URL {
        return URL(string: self.baseURL + self.api + self.version +  self.path)!
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .authToken:
            return URLEncoding.httpBody
        default:
            return JSONEncoding.default
        }
    }
    
}

