//
//  UserLibraryVC.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 06/07/23.
//

import UIKit

class UserLibraryVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet private weak var tblLibraryPlaylist: UITableView!
    @IBOutlet private weak var clvCategory: UICollectionView!
    
    // MARK: - Variables
    private var viewModel = LibraryViewModel()
    private var categories = [ LibraryItemType.all.rawValue.capitalized ,LibraryItemType.playlist.rawValue.capitalized , LibraryItemType.artists.rawValue.capitalized , LibraryItemType.album.rawValue.capitalized , LibraryItemType.podcast.rawValue.capitalized]
    var coordinator: LibraryCoordinator?
    var libraryDisplayItems: [LibraryDisplayData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        viewModel.getAllLibraryData()
        tblLibraryPlaylist.register(UINib(nibName: "LibraryArtistsCell", bundle: nil), forCellReuseIdentifier: "LibraryArtistsCell")
    }
    
    private func bindViewModel() {
        
        viewModel.libraryInitalItems.bind { [weak self] libraryDisplayItems in
            
            if let sSelf = self {
                sSelf.aiLoading.startAnimating()
                sSelf.libraryDisplayItems = libraryDisplayItems
                if libraryDisplayItems.count > 1 {
                    sSelf.libraryDisplayItems.sort {
                        $0.type.index < $1.type.index
                    }
                }
                sSelf.tblLibraryPlaylist.reloadData()
                sSelf.aiLoading.stopAnimating()
            }
        }
    }
}

// MARK: - Tableview datasource
extension UserLibraryVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        libraryDisplayItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        libraryDisplayItems[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if libraryDisplayItems[indexPath.section].type == LibraryItemType.playlist {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath) as? LibraryCell else {
                return UITableViewCell()
            }
            cell.layoutIfNeeded()
            cell.configureCell(data: libraryDisplayItems[indexPath.section].data[indexPath.row], isFiltered: libraryDisplayItems[indexPath.section].isFiltered)
            return cell
        } else if libraryDisplayItems[indexPath.section].type == LibraryItemType.artists {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryArtistsCell", for: indexPath) as? LibraryArtistsCell else {
                return UITableViewCell()
            }
            cell.configureCell(data: libraryDisplayItems[indexPath.section].data[indexPath.row])
            return cell
        } else if libraryDisplayItems[indexPath.section].type == LibraryItemType.album {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryCell", for: indexPath) as? LibraryCell else {
                return UITableViewCell()
            }
            cell.layoutIfNeeded()
            cell.configureCell(data: libraryDisplayItems[indexPath.section].data[indexPath.row], isFiltered: libraryDisplayItems[indexPath.section].isFiltered)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - Tableview delegate
extension UserLibraryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height / 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if libraryDisplayItems[indexPath.section].type == LibraryItemType.playlist {
            coordinator?.gotoViewSongs(songData: libraryDisplayItems[indexPath.section].data[indexPath.row])
        } else if libraryDisplayItems[indexPath.section].type == LibraryItemType.album {
            coordinator?.gotoViewSongs(songData: libraryDisplayItems[indexPath.section].data[indexPath.row])
        }
        
    }
}

// MARK: - Collection view datasource
extension UserLibraryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(title: categories[indexPath.row])
        return cell
    }
}

// MARK: - Collection view delegate
extension UserLibraryVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (categories[indexPath.row] == LibraryItemType.playlist.rawValue.capitalized) {
            viewModel.getLibraryPlaylist()
        }
        else if (categories[indexPath.row] == LibraryItemType.artists.rawValue.capitalized) {
            viewModel.getLibraryArtists()
        } else if (categories[indexPath.row] == LibraryItemType.album.rawValue.capitalized) {
            viewModel.getLibraryAlbum()
        } else if categories[indexPath.row] == LibraryItemType.all.rawValue.capitalized{
            viewModel.getAllLibraryData()
        }
    }
    
}

// MARK: - Collection view flow layout
extension UserLibraryVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 3 - 15, height: 40)
    }
    
}
