//
//  AuthVC.swift
//  My Spotify
//
//  Created by Krunal Patel on 05/07/23.
//

import UIKit

class AuthVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var btnSignIn: UIButton!
    
    // MARK: - Vars & Lets
    var authCoordinator: AuthCoordinator? = nil
    var code: String? = nil
    private let authViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
    }
    
    // MARK: - Methods
    private func bindViewModel() {
        authViewModel.errorMessage.bind { [weak self] error in
            self?.showAlert(title: "Authorization failed", message: error)
        }
        
        authViewModel.isLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.progressIndicator.startAnimating() : self.progressIndicator.stopAnimating()
        }
    }
    
    private func setupUI() {
        setupBtn()
        if let code = code {
            authViewModel.generateAuthToken(with: code)
        }
    }
    
    private func setupBtn() {
        btnSignIn.clipsToBounds = true
        btnSignIn.layer.cornerRadius = 8
    }
    
    // MARK: - IBActions
    @IBAction func actionSignIn(_ sender: UIButton) {
        authViewModel.generateAuthCode()
    }
}
