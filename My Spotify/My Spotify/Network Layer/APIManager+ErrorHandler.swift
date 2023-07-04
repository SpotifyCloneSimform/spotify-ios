//
//  APIManager+ErrorHandler.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 04/07/23.
//


struct APIError {

    // MARK: Alerts
    static let defaultAlertTitle   = "warning"
    static let errorAlertTitle     = "error"
    static let genericErrorMessage = "Something went wrong, please try again."
    static let unprocessableEntity = "Unprocessable Entity"
    static let notFound            = "Not Found"
    static let parameterMissing    = "Missing Param"
    static let unAuthorizeUser     = "Authorisation Error"
    static let noInternet          = "No Internet Connection"
    static let noData              = "No data"
}
