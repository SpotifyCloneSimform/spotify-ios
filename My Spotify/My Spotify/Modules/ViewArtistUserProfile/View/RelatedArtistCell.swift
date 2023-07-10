//
//  RelatedArtistCell.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 10/07/23.
//

import UIKit
import Kingfisher

class RelatedArtistCell: UICollectionViewCell {
    
    // MARK: - outlets
    @IBOutlet private weak var lblArtistName: UILabel!
    @IBOutlet private weak var imgArtist: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgArtist.layoutIfNeeded()
        imgArtist.layer.cornerRadius = imgArtist.bounds.width / 2
        imgArtist.clipsToBounds = true
    }
    
    func configureCell(image: String, name: String) {
        lblArtistName.text = name
        imgArtist.kf.setImage(with: URL(string: image))
    }
}
