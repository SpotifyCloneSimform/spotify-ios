//
//  Category.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

struct CategoriesResponse: Codable {
    
    var categories: Categories?
}

struct Categories: Codable {
    
    var herf: String?
    var items: [Category]?
    var limit: Int?
    var next: String?
    var offset: Int?
    var previous: String?
    var total: Int?
}

struct Category: Codable {
    
    var herf: String?
    var icons: [Icon]?
    var id: String?
    var name: String?
}

struct Icon: Codable {
    
    var height: Int?
    var width: Int?
    var url: String?
}
