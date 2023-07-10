//
//  LibraryArtistsCell.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

import UIKit
import Kingfisher

class LibraryArtistsCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblArtistsName: UILabel!
    @IBOutlet private weak var imgArtists: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imgArtists.layoutIfNeeded()
        imgArtists.layer.cornerRadius = imgArtists.bounds.width / 2
        imgArtists.clipsToBounds = true
    }
    
    func configureCell(data: LibraryDisplay) {
        lblArtistsName.text = data.name
        imgArtists.kf.setImage(with: URL(string: data.image ?? ""))
    }
}
