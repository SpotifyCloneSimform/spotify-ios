//
//  CategoryPlaylistVC.swift
//  My Spotify
//
//  Created by Krunal Patel on 12/07/23.
//

import UIKit

class CategoryPlaylistVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var tblPlaylist: UITableView!
    
    // MARK: - Vars & Lets
    var searchCoordinator: SearchCoordinator?
    var category: Category? = nil
    private let categoryPlaylistViewModel = CategoryPlaylistViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindPlaylist()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        title = category?.name
        tblPlaylist.register(UINib(nibName: "CategoryPlaylistCell", bundle: nil), forCellReuseIdentifier: "CategoryPlaylistCell")
        if let category = category {
            categoryPlaylistViewModel.getPlaylists(category: category)
        }
    }
    
    private func bindViewModel() {
        categoryPlaylistViewModel.errorMessage.bind { [weak self] error in
            self?.showAlert(title: "Search result loading failed", message: error)
        }
    }
    
    private func bindPlaylist() {
        categoryPlaylistViewModel.playlists.bind { [weak self] _ in
            self?.tblPlaylist.reloadData()
        }
    }
}

// MARK: - Table View
extension CategoryPlaylistVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        view.bounds.height / 8
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoryPlaylistViewModel.playlists.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryPlaylistCell", for: indexPath) as? CategoryPlaylistCell else  {
            return UITableViewCell()
        }
        
        cell.configCell(playlist: categoryPlaylistViewModel.playlists.value[indexPath.row])
        return cell
    }
}

extension CategoryPlaylistVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playlist = categoryPlaylistViewModel.playlists.value[indexPath.row]
        let libraryDisplay = LibraryDisplay(name: playlist.name, ownerDisplayName: playlist.owner?.displayName, image: playlist.images?.first?.url, type: .playlist, id: playlist.id)
        searchCoordinator?.goToViewSongs(songData: libraryDisplay)
    }
}
