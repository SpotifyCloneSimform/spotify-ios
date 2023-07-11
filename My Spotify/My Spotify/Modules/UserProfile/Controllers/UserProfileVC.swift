//
//  UserProfileVC.swift
//  My Spotify
//
//  Created by Krunal Patel on 11/07/23.
//

import UIKit
import Kingfisher

class UserProfileVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var imgUserProfile: UIImageView!
    @IBOutlet private weak var txtName: UILabel!
    @IBOutlet private weak var txtEmail: UILabel!
    @IBOutlet private weak var txtFollowers: UILabel!
    @IBOutlet private weak var tblProfileItem: UITableView!
    
    // MARK: - Vars & Lets
    private let userProfileViewModel = UserProfileViewModel()
    var userProfileCoordinator: UserProfileCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindUserProfile()
        bindProfileItems()
        setupUI()
        userProfileViewModel.getAuthorizedUserProfile()
        userProfileViewModel.getProfileItems()
    }
    
    // MARK: - Methods
    private func setupUI() {
        let logoutButton = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(logout))
        logoutButton.tintColor = .white
        navigationItem.rightBarButtonItem = logoutButton
        
        tblProfileItem.register(UINib(nibName: "ProfileItemCell", bundle: nil), forCellReuseIdentifier: "ProfileItemCell")
        imgUserProfile.clipsToBounds = true
        imgUserProfile.layer.cornerRadius = imgUserProfile.bounds.height / 2
    }
    
    private func bindViewModel() {
        userProfileViewModel.errorMessage.bind { [weak self] error in
            self?.showAlert(title: "Options loading failed", message: error)
        }
    }
    
    private func bindUserProfile() {
        userProfileViewModel.userProfile.bind { [weak self] userProfile in
            guard let self = self, let userProfile = userProfile else { return }
            
            self.imgUserProfile.kf.setImage(with: URL(string: userProfile.images?.first?.url ?? ""), placeholder: UIImage(named: "RoundProfile"))
            self.txtName.text = userProfile.displayName
            self.txtEmail.text = userProfile.email
            self.txtFollowers.text = "\(userProfile.followers?.total ?? 0) followers"
            
        }
    }
    
    private func bindProfileItems() {
        userProfileViewModel.profileItems.bind { [weak self] _ in
            self?.tblProfileItem.reloadData()
        }
        
        userProfileViewModel.itemUpdate.bind { [weak self] indexPath in
            self?.tblProfileItem.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    @objc
    private func logout() {
        userProfileViewModel.logout()
        userProfileCoordinator?.logout()
    }
}

// MARK: - Table View
extension UserProfileVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        userProfileViewModel.profileItems.value.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userProfileViewModel.profileItems.value[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileItemCell", for: indexPath) as? ProfileItemCell else {
            return UITableViewCell()
        }
        
        let item = userProfileViewModel.profileItems.value[indexPath.section].items[indexPath.row]
        cell.configCell(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        44
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.frame.width), height: 44))
        let headerTitle = UILabel(frame: CGRect(x: 18, y: 0, width: Int(header.frame.width), height: Int(header.frame.height)))
        headerTitle.text = userProfileViewModel.profileItems.value[section].title
        headerTitle.font = headerTitle.font.withSize(20)
        header.addSubview(headerTitle)
        return header
    }
}

extension UserProfileVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playlist = userProfileViewModel.profileItems.value[indexPath.section].items[indexPath.row]
        let libraryDisplay = LibraryDisplay(name: playlist.name, ownerDisplayName: playlist.ownerName, image: playlist.image, type: .playlist, id: playlist.id)
        userProfileCoordinator?.goToViewSongs(songData: libraryDisplay)
    }
}
