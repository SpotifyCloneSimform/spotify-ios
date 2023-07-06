//
//  CategoryCell.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var btnCategory: UIButton!
    
    func configureCell(title: String) {
        btnCategory.setTitle(title, for: .normal)
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        layer.cornerRadius = bounds.height / 2 - 10

        let transparentView = UIView(frame: bounds.insetBy(dx: 0, dy:  -30))
        transparentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        backgroundView = transparentView

        var frameView = frame
        frameView.size.height -= 30
        frameView.size.width -= 30
        let darkGreenView = UIView(frame: frameView)
        darkGreenView.backgroundColor = UIColor(named: "DarkGreen")
        selectedBackgroundView = darkGreenView
    }
}
