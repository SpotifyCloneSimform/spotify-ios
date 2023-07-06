//
//  LibraryCell.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

import UIKit
import Kingfisher

class LibraryCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblUserName: UILabel!
    @IBOutlet private weak var lblPlaylistName: UILabel!
    @IBOutlet private weak var imgPlaylist: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(data: LibraryDisplay, isFiltered: Bool) {
        
        lblPlaylistName.text = data.name
        if !isFiltered {
            if data.type == LibraryItemType.album {
                lblUserName.text = "Album • \(data.ownerDisplayName ?? "NA")"
            } else {
                lblUserName.text = "Playlist • \(data.ownerDisplayName ?? "NA")"
            }
        } else {
            lblUserName.text = data.ownerDisplayName ?? "NA"
        }
        imgPlaylist.kf.setImage(with: URL(string: data.image ?? ""))
    }
}
