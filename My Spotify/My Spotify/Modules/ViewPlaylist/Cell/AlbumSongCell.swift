//
//  AlbumSongCell.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 07/07/23.
//

import UIKit

class AlbumSongCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblArtistName: UILabel!
    @IBOutlet private weak var lblSongName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(data: DisplaySongData) {
        lblSongName.text = data.songName
        lblArtistName.text = data.artistsName
    }
}
