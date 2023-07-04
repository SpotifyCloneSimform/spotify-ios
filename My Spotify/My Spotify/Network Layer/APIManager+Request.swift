//
//  ApiManager+Request.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//

import Foundation
import Alamofire
enum RequestItemsType: Equatable {
    
}

// MARK: Extensions
// MARK: EndPointType

extension RequestItemsType: EndPointType {

    // MARK: Vars & Lets
    
    var baseURL: String {
        return ""
    }
    
    var api: String {
        return "api/"
    }
    
    var version: String {
        return "v1/"
    }
    
    var path: String {
       return ""
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var headers: HTTPHeaders? {
       return HTTPHeaders()
    }
    
    var url: URL {
       return URL(string: "")!
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
}

