//
//  SearchItemCell.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

import UIKit
import Kingfisher

class SearchItemCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var imgItem: UIImageView!
    @IBOutlet private weak var txtName: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet private weak var txtDescription: UILabel!
    
    // MARK: - Variables
    var onClick: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func btnMoreClick(_ sender: UIButton) {
         onClick?()
    }
    
    // MARK: - Methods
    func configCell(item: SearchItem) {
        imgItem.kf.setImage(with: URL(string: item.image))
        txtName.text = item.name
        txtDescription.text = item.description
        btnMore.isHidden = item.type == .track ? false : true
    }
}
