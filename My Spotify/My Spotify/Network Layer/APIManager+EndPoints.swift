//
//  APIManager+EndPoints.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//

import Alamofire

protocol EndPointType {
    
    // MARK: Variables
    
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var url: URL { get }
    var encoding: ParameterEncoding { get }
    var version: String { get }
    
}
