//
//  ViewPodcastVC.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 12/07/23.
//

import UIKit
import Kingfisher

class ViewPodcastVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var lblPublisherTitle: UILabel!
    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var tblShows: UITableView!
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var imgPublisher: UIImageView!
    @IBOutlet private weak var lblDescription: UILabel!
    
    // MARK: - Variables
    private var shows: PodcastShowDetail?
    private let viewModel = ViewPodcastViewModel()
    var coordinator: PodcastShowCoordinator?
    var show: LibraryDisplay?
    private var initalHeaderHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        bindViewModel()
    }
    
    private func setUpUI() {
        initalHeaderHeight = headerView.bounds.height
        navigationItem.largeTitleDisplayMode = .never
        lblPublisherTitle.text = show?.name
        lblName.text = show?.ownerDisplayName 
        lblDescription.text = show?.description
        imgPublisher.kf.setImage(with: URL(string: show?.image ?? ""))
        if let show = show {
            viewModel.getPodscastProfile(id: show.id ?? "")
        }
    }
    
    private func bindViewModel() {
        viewModel.shows.bind { [weak self] shows in
            if let self = self {
                self.shows = shows
                self.tblShows.reloadData()
            }
        }
        
        viewModel.failure.bind { [weak self] message in
            self?.showAlert(title: message)
        }
    }
    
    @IBAction func btnSeeMoreClick(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            lblDescription.numberOfLines = 0
            tblShows.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerView.bounds.height + lblDescription.frame.height + 150)
        } else {
            lblDescription.numberOfLines = 2
            tblShows.tableHeaderView?.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: initalHeaderHeight ?? 0)
        }
        tblShows.layoutIfNeeded()
        tblShows.layoutSubviews()
        tblShows.reloadData()
    }
}

// MARK: - Tableview datasource
extension ViewPodcastVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shows?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastCellTableViewCell", for: indexPath) as? PodcastCellTableViewCell else {
            return UITableViewCell()
        }
        if let data = shows?.items, let name = show?.name {
            cell.configureCell(data: data[indexPath.row], name: name)
        }
        return cell
    }
}

// MARK: - Tableview Delegate
extension ViewPodcastVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
