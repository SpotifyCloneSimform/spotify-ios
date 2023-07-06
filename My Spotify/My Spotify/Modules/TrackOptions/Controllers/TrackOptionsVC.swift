//
//  TrackOptionsVC.swift
//  My Spotify
//
//  Created by Krunal Patel on 07/07/23.
//

import UIKit

class TrackOptionsVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var imgSong: UIImageView!
    @IBOutlet private weak var txtSongName: UILabel!
    @IBOutlet private weak var tblTrackOptions: UITableView!
    @IBOutlet private weak var txtSongDescription: UILabel!
    
    // MARK: - Vars & Lets
    private let trackOptionsViewModel = TrackOptionsViewModel()
    private let options = Dynamic<[OptionItem]>([])
    var trackOptionsCoordinator: TrackOptionsCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        bindTrack()
        bindOptions()
    }
    
    // MARK: - Methods
    private func setupUI() {
        if let trackId = trackOptionsCoordinator?.trackId {
            trackOptionsViewModel.getTrackDetails(trackId: trackId)
        }
    }
    
    private func bindViewModel() {
        trackOptionsViewModel.errorMessage.bind { [weak self] error in
            self?.showAlert(title: "Options loading failed", message: error)
        }
    }
    
    private func bindTrack() {
        trackOptionsViewModel.track.bind { [weak self] track in
            guard let self = self else { return }
            
            self.txtSongName.text = track?.name
            self.txtSongDescription.text = track?.artists?.first?.name
            if let image = track?.album?.images?.first?.url {
                self.imgSong.kf.setImage(with: URL(string: image))
            }
        }
    }
    
    private func bindOptions() {
        trackOptionsViewModel.reloadOptions.bind { [weak self] in
            self?.reloadOptions()
            self?.tblTrackOptions.reloadData()
        }
    }
    
    private func reloadOptions() {
        
        options.value = [
            OptionItem(
                iconName: trackOptionsViewModel.isLiked.value ? "HeartFilled" : "HeartOutlined",
                title: trackOptionsViewModel.isLiked.value ? "Liked" : "Like") { [weak self] in
                    guard let self = self else { return }
                    
                        self.trackOptionsViewModel.toggleLike(isLike: !self.trackOptionsViewModel.isLiked.value)
                },
            
            OptionItem(iconName: "Album", title: "Album") { [weak self] in
                guard let self = self else { return }
                
                if let trackId = self.trackOptionsViewModel.track.value?.id {
                    self.trackOptionsCoordinator?.goToAlbum(trackId: trackId)
                }
            }
        ]
    }
}

// MARK: - Table View
extension TrackOptionsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrackOptionCell", for: indexPath) as? TrackOptionCell else {
            return UITableViewCell()
        }
        
        cell.configCell(option: options.value[indexPath.row])
        return cell
    }
}

extension TrackOptionsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        options.value[indexPath.row].onClick?()
    }
}
