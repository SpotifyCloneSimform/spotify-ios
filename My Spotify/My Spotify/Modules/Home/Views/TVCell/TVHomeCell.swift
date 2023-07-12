//
//  TVHomeCell.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 05/07/23.
//

import UIKit

class TVHomeCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var clvPlaylist: UICollectionView!
    
    // MARK: - Variables
    var items: [HomeDisplayData] = []
    var onClick: ((LibraryDisplay) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUI()
    }
    
    private func setUpUI() {
        clvPlaylist.delegate = self
        clvPlaylist.dataSource = self
        clvPlaylist.register(UINib(nibName: "CVPlaylist", bundle: nil), forCellWithReuseIdentifier: "CVPlaylist")
    }

}

// MARK: - Collection view Datasource
extension TVHomeCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVPlaylist", for: indexPath) as? CVPlaylist else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(name: items[indexPath.row].name ?? "", imageUrl: items[indexPath.row].image ?? "")
        cell.layoutIfNeeded()
        return cell
    }

}

// MARK: - Colelction view Delegate
extension TVHomeCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width / 2 - 30, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let libraryDisplay = items.map { libraryDisplayData in
            LibraryDisplay(name: libraryDisplayData.name, ownerDisplayName: libraryDisplayData.ownerName, image: libraryDisplayData.image, type: libraryDisplayData.type ?? .playlist, id: libraryDisplayData.id)
            
        }
        onClick?(libraryDisplay[indexPath.row])
    }
}
