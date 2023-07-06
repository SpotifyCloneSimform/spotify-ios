//
//  ApiManager.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//

import Alamofire
import UIKit
import Reachability

class APIManager {
    
    // MARK: Vars & Lets
    private let sessionManager: Session
    private let interceptor: APIManagerInterceptor
    let reachability = try? Reachability()
    static let shared = APIManager(interceptor: APIManagerInterceptor())
    static let errorCodeList =  [400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 421, 422, 423, 424, 425, 426, 427, 428, 429, 431, 451, 500, -1009, -1001]
    
    // MARK: Methods
    func call<T>(type: RequestItemsType, params: Parameters? = nil, handler: @escaping (Result<T, CustomError>) -> Void) where T: Codable {
        
        guard reachability?.connection ?? .unavailable != .unavailable else {
            handler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.noInternet)))
            return
        }
        
        self.sessionManager.request(type.url,
                                    method: type.httpMethod,
                                    parameters: params,
                                    encoding: type.encoding,
                                    headers: type.headers).validate().responseData { (data) in
            if self.handleResponseCode(res: data) {
                do {
                    guard let jsonData = data.data else {
                        handler(.failure(.init(title: APIError.errorAlertTitle, body: APIError.noData)))
                        return
                    }
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try jsonDecoder.decode(T.self, from: jsonData)
                    
                    handler(.success(result))
                    
                } catch {
                    handler(.failure(.init(title: APIError.errorAlertTitle, body: APIError.genericErrorMessage)))
                }
            } else {
                handler(.failure(CustomError(title: APIError.errorAlertTitle, body: APIError.genericErrorMessage)))
            }
        }
    }
    
    // Handle Response
    private func handleResponseCode(res: AFDataResponse<Data>?) -> Bool {
        var isSuccess: Bool = false
        
        guard let dataResponse = res else {
            return isSuccess
        }
        guard let response = dataResponse.response else {
            return isSuccess
        }
        
        switch response.statusCode {
        case 200...300:
            isSuccess = true
        default: break
        }
        
        return isSuccess
    }
    
    // MARK: - Initializer
    private init(interceptor: APIManagerInterceptor) {
        self.interceptor = interceptor
        self.sessionManager = Session(interceptor: interceptor)
    }
    
}
