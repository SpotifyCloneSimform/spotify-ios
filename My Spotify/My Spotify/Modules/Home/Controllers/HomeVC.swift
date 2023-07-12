//
//  ViewController.swift
//  My Spotify
//
//  Created by Krunal Patel on 04/07/23.
//

import UIKit

class HomeVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var tblHome: UITableView!
    
    // MARK: - Vars & Lets
    var homeCoordinator: HomeCoordinator?
    private var viewModel = HomeViewModel()
    private var homeItems: [HomeDisplay] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUpBind()
    }
    
    private func setUpUI() {
        
        viewModel.getPlaylist()
        viewModel.getAlbumbs()
        viewModel.getFeaturedPlaylist()
        tblHome.register(UINib(nibName: "TVHomeHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "TVHomeHeader")
        tblHome.setContentOffset(CGPoint(x: 0, y: -1), animated: false)
        
    }
    
    
    private func setUpBind() {
        viewModel.getAllData.bind { [weak self] homeItems in
            guard let self = self else { return }
            
            self.homeItems = homeItems
            self.tblHome.layoutIfNeeded()
            self.tblHome.reloadData()
            
        }
    }
}

 // MARK: - Tableview Datasource
extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        homeItems.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TVHomeCell", for: indexPath) as? TVHomeCell else {
            return UITableViewCell()
        }
        
        if let data = homeItems[indexPath.section].data {
            cell.items = data
            cell.clvPlaylist.reloadData()
            cell.onClick = { [weak self] data in
                self?.homeCoordinator?.gotoViewSongs(songData: data)
            }
        }
        cell.clvPlaylist.layoutIfNeeded()
        return cell
        
    }
}

// MARK: - Tableview Delegate
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.bounds.height / 3 + 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TVHomeHeader") as? TVHomeHeader else {
            return UIView()
        }   
        sectionHeader.configureCell(title: homeItems[section].sectionName ?? "")
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}
