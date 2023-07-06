//
//  UIColor+extentions.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1)
    }
    
    static func fromName(_ name: String?) -> UIColor? {
        switch name {
        case "red":
            return UIColor.red
        case "blue":
            return UIColor.blue
        case "brown":
            return UIColor.brown
        case "green":
            return UIColor.green
        case "yellow":
            return UIColor.yellow
        case "black":
            return UIColor.black
        case "white":
            return UIColor.white
        default :
            return nil
        }
    }
}
