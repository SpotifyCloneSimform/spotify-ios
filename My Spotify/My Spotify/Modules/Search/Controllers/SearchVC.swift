//
//  SearchVC.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

import UIKit

class SearchVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var categoriesCollectionView: UICollectionView!
    
    // MARK: - Vars & Lets
    private let searchViewModel = SearchViewModel()
    var searchCoordinator: SearchCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindCategories()
        setupUI()
    }
    
    // MARK: - Methods
    private func bindViewModel() {
        searchViewModel.errorMessage.bind { [weak self] error in
            self?.showAlert(title: "Category loading failed", message: error)
        }
    }
    
    private func bindCategories() {
        searchViewModel.categories.bind { [weak self] error in
            guard let self = self else { return }
            
            self.categoriesCollectionView.reloadData()
        }
    }
    
    private func setupUI() {
        searchViewModel.fetchCategories()
    }
    
    // MARK: - IBActions
    @IBAction func actionSearch(_ sender: UIButton) {
        searchCoordinator?.goToSearchScreen()
    }
}

// MARK: - Collection View
extension SearchVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.categories.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCategoryCell", for: indexPath) as? SearchCategoryCell else  {
            return UICollectionViewCell()
        }
        
        let category = searchViewModel.categories.value[indexPath.item]
        
        cell.configCell(category: category)
        return cell
    }
    
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 10, height: collectionView.bounds.height / 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
