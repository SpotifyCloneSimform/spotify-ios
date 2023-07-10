//
//  SongCell.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

import UIKit
import Kingfisher

class SongCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblSongName: UILabel!
    @IBOutlet private weak var imgSong: UIImageView!
    @IBOutlet private weak var lblArtistsName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(song: DisplaySongData) {
        lblSongName.text = song.songName
        lblArtistsName.text = song.artistsName
        imgSong.kf.setImage(with: URL(string: song.image ?? ""))
    }
    
}
