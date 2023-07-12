//
//  HomeDisplayData.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import Foundation
struct HomeDisplay {
    let sectionName: String?
    let data: [HomeDisplayData]?
}

struct HomeDisplayData {
    let name: String?
    let image: String?
    let url: String?
    let ownerName: String?
    let id: String?
    let type: LibraryItemType?
}
