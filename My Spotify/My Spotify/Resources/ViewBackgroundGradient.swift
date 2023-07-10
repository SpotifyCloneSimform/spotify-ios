//
//  ViewBackgroundGradient.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 10/07/23.
//

import Foundation
import UIKit

class ViewGradient: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        
        let startColor = UIColor(named: "tranparent")
        let endColor = UIColor.black.cgColor
        gradient.colors = [startColor ?? UIColor.black, endColor]
        gradient.locations = [0, 0.25, 0.75, 1]
        layer.insertSublayer(gradient, at: 0)
        return gradient
    }()
}
