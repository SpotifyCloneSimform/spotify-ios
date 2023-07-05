//
//  KeychainHelper.swift
//  My Spotify
//
//  Created by Krunal Patel on 05/07/23.
//

import SwiftKeychainWrapper

class KeychainHelper {
    
    private init() {}
    
    // MARK: - Vars & Lets
    static let shared = KeychainHelper()
    private let keychain = KeychainWrapper.standard
    
    var accessToken: String? {
        get {
            keychain[.accessToken]
        } set {
            keychain[.accessToken] = newValue
        }
    }
    
    var refreshToken: String? {
        get {
            keychain[.refreshToken]
        } set {
            keychain[.refreshToken] = newValue
        }
    }
    
    var expiryTime: Int? {
        get {
            keychain[.expiryTime]
        } set {
            keychain[.expiryTime] = newValue
        }
    }
    
    // MARK: - Methods
    func clearData() {
        keychain.removeAllKeys()
    }
}

// MARK: - Extention Keys
extension KeychainWrapper.Key {
    
    // Auth
    static let accessToken: KeychainWrapper.Key = "accessToken"
    static let refreshToken: KeychainWrapper.Key = "refreshToken"
    static let expiryTime: KeychainWrapper.Key = "expiryTime"
}
