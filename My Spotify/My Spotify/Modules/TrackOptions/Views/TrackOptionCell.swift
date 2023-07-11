//
//  TrackOptionCell.swift
//  My Spotify
//
//  Created by Krunal Patel on 10/07/23.
//

import UIKit

class TrackOptionCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var imgOption: UIImageView!
    @IBOutlet private weak var txtTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Methods
    func configCell(option: OptionItem) {
        imgOption.image = UIImage(named: option.iconName)
        txtTitle.text = option.title
    }
}
