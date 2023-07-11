//
//  ArtistProfileVC.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 10/07/23.
//

import UIKit
import Kingfisher

class ArtistProfileVC: UIViewController, Storyboarded {

    // MARK: - Outlets
    @IBOutlet private weak var imgArtist: UIImageView!
    @IBOutlet private weak var artistProfileHeader: UIView!
    @IBOutlet private weak var lblArtistName: UILabel!
    @IBOutlet private weak var lblArtistFollowers: UILabel!
    @IBOutlet private weak var aiLoading: UIActivityIndicatorView!
    @IBOutlet private weak var tblTopTracks: UITableView!
    @IBOutlet private weak var clvRelatedArtist: UICollectionView!
    
    // MARK: - Variables
    var coordinator: ViewArtistCoordinator?
    var artistId: String?
    private let viewModel = ArtistProfileViewModel()
    private var artistTopTracks: ArtistTopTracks? = nil
    private var relatedArtist: RelatedArtists? = nil
    var songs: DisplaySong = DisplaySong(type: nil, data: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindViewModel()
    }
    
    private func setUpUI() {
        tblTopTracks.tableHeaderView = artistProfileHeader
        if let artistId = artistId {
            viewModel.getArtistProfile(id: artistId)
            viewModel.getArtistTopTracks(id: artistId)
            viewModel.getRelatedArtists(id: artistId)
        }
    }
    
    private func bindViewModel() {
        viewModel.artist.bind { [weak self] artist in
            if let self = self, let artist = artist {
                DispatchQueue.main.async {
                    self.lblArtistName.text = artist.name
                    self.lblArtistFollowers.text = "Followers \(artist.followers?.total ?? 0)"
                    self.imgArtist.kf.setImage(with: URL(string: artist.images?.first?.url ?? ""), placeholder: UIImage(named: "RoundProfile"))
                    
                }
            }
        }
        
        viewModel.artistTopTracks.bind { [weak self] topTracks in
            if let self = self {
                self.artistTopTracks = topTracks
                DispatchQueue.main.async { [self] in
                    self.tblTopTracks.reloadData()
                    self.aiLoading.stopAnimating()
                }
                
                var songData = topTracks?.tracks?.map({ item in
                    let artists = item.album?.artists?.compactMap { $0.name }.joined(separator: ", ")
                    return DisplaySongData(songName: item.name, artistsName: artists, image: item.album?.images?.first?.url, id: item.id, songDuration: item.durationMs)
                }) ?? []
                self.songs.type = .artists
                self.songs.data = songData as? [DisplaySongData]
                self.coordinator?.songs = self.songs
            }
        }
        
        viewModel.relatedArtist.bind { [weak self] relatedArtist in
            if let self = self {
                self.relatedArtist = relatedArtist
                DispatchQueue.main.async {
                    self.clvRelatedArtist.reloadData()
                }
            }
        }
    }

}

// MARK: - Tableview datasource
extension ArtistProfileVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        artistTopTracks?.tracks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistTopTrackCell", for: indexPath) as? ArtistTopTrackCell else {
            return UITableViewCell()
        }
        cell.configureCell(songName: artistTopTracks?.tracks?[indexPath.row].name ?? "N/A" ,imgUrl: artistTopTracks?.tracks?[indexPath.row].album?.images?.first?.url ?? "N/A")
        return cell
        
    }
}

// MARK: - Tableview delegate
extension ArtistProfileVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.goToViewSong(currentSong: indexPath.row)
    }
}

// MARK: - Collection view Datasource
extension ArtistProfileVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        relatedArtist?.artists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedArtistCell", for: indexPath) as? RelatedArtistCell else {
            return UICollectionViewCell()
        }
        
        cell.configureCell(image: relatedArtist?.artists?[indexPath.row].images?.first?.url ?? "", name: relatedArtist?.artists?[indexPath.row].name ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = relatedArtist?.artists?[indexPath.row].id {
            coordinator?.viewArtist(id: id)
        }
    }
}

// MARK: - Collection view delegate
extension ArtistProfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 30, height: view.bounds.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        40
    }
    
}
