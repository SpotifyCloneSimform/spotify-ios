//
//  ArtistTopTrackCell.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 10/07/23.
//

import UIKit
import Kingfisher

class ArtistTopTrackCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblSongName: UILabel!
    @IBOutlet private weak var imgSong: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(songName: String, imgUrl: String) {
        lblSongName.text = songName
        var gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = imgSong.frame
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.locations = [0.0, 0.5]
        imgSong.layer.addSublayer(gradient)
        imgSong.kf.setImage(with: URL(string: imgUrl))
    }
}
