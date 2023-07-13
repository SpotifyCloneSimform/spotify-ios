//
//  CategoryPlaylistCellTableViewCell.swift
//  My Spotify
//
//  Created by Krunal Patel on 12/07/23.
//

import UIKit

class CategoryPlaylistCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var imgIcon: UIImageView!
    @IBOutlet private weak var txtName: UILabel!
    @IBOutlet private weak var txtDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Methods
    func configCell(playlist: Playlist) {
        if let image = playlist.images?.first?.url {
            imgIcon.kf.setImage(with: URL(string: image))
        }
        
        txtName.text = playlist.name
        txtDescription.text = playlist.owner?.displayName
    }
}
