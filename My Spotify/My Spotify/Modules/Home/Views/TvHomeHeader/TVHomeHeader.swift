//
//  TVHomeHeader.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import UIKit

class TVHomeHeader: UITableViewHeaderFooterView {

    // MARK: - Outlets
    @IBOutlet private weak var lblHeaderTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(title: String) {
        lblHeaderTitle.text = title
    }
}
