//
//  CustomError.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//

class CustomError: Error {

    // MARK: Vars & Lets
    var title = ""
    var body = ""

    // MARK: Intialization
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }

}

class NetworkError: Codable {

    let error: ApiError

}

class ApiError: Codable {
    
    let status: Int
    let message: String
    
}
