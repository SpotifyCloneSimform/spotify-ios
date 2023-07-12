//
//  ViewSongVC.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 11/07/23.
//

import UIKit
import Kingfisher

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
    var viewModel = ViewSongViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindViewModel()
    }
    
    private func setUpUI() {
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
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(skipToPrevious))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(skipToNext))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func skipToNext() {
        if let currentSong = currentSong, let totalSongs = songs?.data?.count {
            if (currentSong + 1) < totalSongs {
                let randomInt = Int.random(in: 0...totalSongs)
                self.currentSong = btnSuffle.isSelected ? randomInt : currentSong + 1
                setUpUI()
            }
        }
    }
    
    @objc func skipToPrevious() {
        if let currentSong = currentSong {
            if (currentSong - 1) >= 0 {
                self.currentSong = currentSong - 1
                setUpUI()
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
        
        viewModel.reloadData.bind { 
            self.btnLike.isSelected.toggle()
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
        if let currentSong = currentSong, let totalSongs = songs?.data?.count {
            if (currentSong + 1) < totalSongs {
                let randomInt = Int.random(in: 0...totalSongs)
                self.currentSong = btnSuffle.isSelected ? randomInt : currentSong + 1
                setUpUI()
            }
        }
    }
    
    @IBAction func btnSkipPrevious(_ sender: UIButton) {
        if let currentSong = currentSong {
            if (currentSong - 1) >= 0 {
                self.currentSong = currentSong - 1
                setUpUI()
            }
        }
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
