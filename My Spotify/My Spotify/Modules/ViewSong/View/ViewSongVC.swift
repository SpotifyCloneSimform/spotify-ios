//
//  ViewSongVC.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 11/07/23.
//

import UIKit
import Kingfisher
import MotionToastView

class ViewSongVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var imgThumbnail: UIImageView!
    @IBOutlet private weak var lblSongRemainingSec: UILabel!
    @IBOutlet private weak var lblSongCompletedSec: UILabel!
    @IBOutlet private weak var imgLike: UIButton!
    @IBOutlet private weak var lblTitleHeader: UILabel!
    @IBOutlet private weak var lblSubtitleHeader: UILabel!
    @IBOutlet private weak var btnLike: UIButton!
    @IBOutlet private weak var btnSuffle: UIButton!
    @IBOutlet private weak var lblArtistName: UILabel!
    @IBOutlet private weak var lblSongName: UILabel!
    
    // MARK: - variables
    var coordinator: ViewSongCoordinator?
    var songs: DisplaySong?
    var currentSong: Int?
    var trackId: String?
    var viewModel = ViewSongViewModel()
    var albumSongs: DisplaySong = DisplaySong(type: .album, data: [])
    var currentTrack: Track?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindViewModel()
    }
    
    override open var shouldAutorotate: Bool {
          return false
    }
    
    private func setUpUI() {
        if !(trackId?.isEmpty ?? true), let trackId = trackId {
            viewModel.getTrack(trackId: trackId)
        } else {
            setDataToUI()
        }
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(skipToPrevious))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(skipToNext))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    private func setDataToUI() {
        if let songs = songs, let currentSong = currentSong, let imageUrl = songs.data?[currentSong].image {
            imgThumbnail.layer.cornerRadius = 20
            imgThumbnail.kf.setImage(with: URL(string: imageUrl))
            
            if songs.type == .artists {
                lblTitleHeader.text = "Playing from Artist".uppercased()
                lblSubtitleHeader.text = songs.data?[currentSong].artistsName
            } else {
                lblTitleHeader.text = songs.data?[currentSong].title?.uppercased()
                lblSubtitleHeader.text = songs.data?[currentSong].subTitle
            }
            
            lblSongName.text = songs.data?[currentSong].songName
            lblArtistName.text = songs.data?[currentSong].artistsName
            
            if let ms = songs.data?[currentSong].songDuration {
                lblSongRemainingSec.text = ms.msToSeconds.minuteSecondMS
            }
            if let id = songs.data?[currentSong].id {
                viewModel.checkLike(trackId: id)
            }
        }
    }
    
    private func bindViewModel() {
        viewModel.isLiked.bind { [weak self] isLiked in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.btnLike.isSelected = isLiked
            }
        }
        
        viewModel.track.bind { [weak self] track in
            guard let self = self else {
                return
            }
            if let albumId = track?.album?.id {
                self.viewModel.getAlbumTracks(albumId: albumId)
            }
            self.currentTrack = track
        }
        
        viewModel.songs.bind { [weak self] songs in
            guard let self = self else {
                return
            }
            self.songs = songs
            self.currentSong = songs?.data?.enumerated().first { $0.element.id  == self.trackId }?.offset ?? 0
            self.setDataToUI()
        }
        
        viewModel.reloadData.bind { [weak self] in

            self?.btnLike.isSelected.toggle()
            if let isLiked = self?.btnLike.isSelected {
                let image = (UIImage(systemName: "checkmark") ?? UIImage(systemName: "trash"))?                   .withTintColor(.white).withRenderingMode(.alwaysOriginal)
                
                let msg = isLiked ? "Added to Liked Songs" : "Removed From Liked Songs"
                self?.MotionToast_Customisation(header: "", message: msg,
                                                headerColor: UIColor.blue,
                                                messageColor: UIColor(red: 239.0, green: 239.0, blue: 239.0, alpha: 0.7),
                                                primary_color: UIColor(named: "DarkGreen") ?? UIColor.blue,
                                                secondary_color: UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0), icon_image: image!,
                                                duration: .short, toastStyle: .style_vibrant,
                                                toastGravity: .bottom, toastCornerRadius: 8, pulseEffect: false)
            }
            
        }
        
        viewModel.errorMessage.bind { [weak self] message in
            self?.showAlert(title: message)
        }
    }
    
    @objc func skipToNext() {
        if let currentSong = currentSong, let totalSongs = songs?.data?.count {
            if (currentSong + 1) < totalSongs {
                let randomInt = Int.random(in: 0...totalSongs)
                self.currentSong = btnSuffle.isSelected ? randomInt : currentSong + 1
                setDataToUI()
            }
        }
    }
    
    @objc func skipToPrevious() {
        if let currentSong = currentSong {
            if (currentSong - 1) >= 0 {
                self.currentSong = currentSong - 1
                setDataToUI()            }
        }
    }
    
    @IBAction func btnPausePlay(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func btnLike(_ sender: UIButton) {
        if let currentSong = currentSong, let id = songs?.data?[currentSong].id {
            viewModel.updateLike(trackId: id, isLiked: !sender.isSelected)
        }
    }
    
    @IBAction func btnDismissView(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func btnSkipNext(_ sender: UIButton) {
        skipToNext()
    }
    
    @IBAction func btnSkipPrevious(_ sender: UIButton) {
        skipToPrevious()
    }
    
    @IBAction func btnSuffle(_ sender: UIButton) {
        if sender.isSelected {
            sender.tintColor = UIColor(named: "AccentColor")
        } else {
            sender.tintColor = UIColor.white
        }
    }
    
    @IBAction func btnOnRepeat(_ sender: UIButton) {
        if sender.isSelected {
            sender.tintColor = UIColor(named: "AccentColor")
        } else {
            sender.tintColor = UIColor.white
        }
    }
    
}
