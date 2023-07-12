//
//  ProfileItemCell.swift
//  My Spotify
//
//  Created by Krunal Patel on 12/07/23.
//

import UIKit
import Kingfisher

class ProfileItemCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var imgIcon: UIImageView!
    @IBOutlet private weak var txtName: UILabel!
    @IBOutlet private weak var txtArtists: UILabel!
    @IBOutlet private weak var txtFollowers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Methods
    func configCell(item: ProfileItem) {
        if let image = item.image {
            imgIcon.kf.setImage(with: URL(string: image))
        }
        
        txtName.text = item.name
        txtFollowers.text = "\(item.followers) followers"
        txtArtists.text = item.artists?.joined(separator: ",") ?? "No artist"
    }    
}
