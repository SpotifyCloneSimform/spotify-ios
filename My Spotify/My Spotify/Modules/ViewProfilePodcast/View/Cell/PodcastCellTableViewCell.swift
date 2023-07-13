//
//  PodcastCellTableViewCell.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 12/07/23.
//

import UIKit
import Kingfisher

class PodcastCellTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblShowName: UILabel!
    @IBOutlet private weak var lblPublisherName: UILabel!
    @IBOutlet private weak var lblPodcastDescription: UILabel!
    @IBOutlet private weak var btnPlayPause: UIButton!
    @IBOutlet private weak var lblAddedAt: UILabel!
    @IBOutlet private weak var imgPodcast: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(data: PodcastShowsItems, name: String) {
        lblShowName.text = data.name
        lblPublisherName.text = name
        lblPodcastDescription.text = data.description
        imgPodcast.kf.setImage(with: URL(string: data.images?.first?.url ?? ""))
        lblAddedAt.text = "Release date : \(data.releaseDate ?? "N/A")"
        
    }
}

