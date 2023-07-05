//
//  CVPlaylist.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import UIKit
import Kingfisher

class CVPlaylist: UICollectionViewCell {
    
    //MARK: Outlets
    @IBOutlet private weak var lblPlaylistName: UILabel!
    @IBOutlet private weak var imgPlaylist: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(name: String, imageUrl: String) {
        lblPlaylistName.text = name
        imgPlaylist.kf.setImage(with: URL(string: imageUrl))
    }
}
