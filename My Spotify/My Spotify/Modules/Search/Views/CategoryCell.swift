//
//  CategoryCell.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

import UIKit
import Kingfisher

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var txtTitle: UILabel!
    @IBOutlet private weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    // MARK: - Methods
    private func setupView() {
        containerView.backgroundColor = .random()
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 8
        imgIcon.clipsToBounds = true
        imgIcon.layer.cornerRadius = 10
        imgIcon.transform = imgIcon.transform.rotated(by: .pi/4)
    }
    
    func configCell(category: Category) {
        
        txtTitle.text = category.name
        if let url = category.icons?.first?.url {
            imgIcon.kf.setImage(with: URL(string: url))
        }
    }
}
