//
//  SearchHistoryVC.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

import UIKit
import Combine

class SearchHistoryVC: UIViewController, Storyboarded {
    
    // MARK: - Outlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tblSearch: UITableView!
    
    // MARK: - Vars & Lets
    private let searchHistoryViewModel = SearchHistoryViewModel()
    var searchCoordinator: SearchCoordinator?
    var cancellable = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        bindSearch()
        setupUI()
    }
    
    // MARK: - Methods
    private func bindViewModel() {
        searchHistoryViewModel.errorMessage.bind { [weak self] error in
            self?.showAlert(title: "Search result loading failed", message: error)
        }
    }
    
    private func bindSearch() {
        searchHistoryViewModel.searchItems.bind { [weak self] items in
            self?.tblSearch.reloadData()
        }
    }
    
    private func setupUI() {
        applyDebounceSearch()
    }
    
    private func applyDebounceSearch() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
        publisher
            .compactMap {
                ($0.object as? UISearchTextField)?.text
            }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .sink(receiveValue: { [weak self] query in
                    self?.searchHistoryViewModel.search(query: query)
            })
            .store(in: &cancellable)
    }
}

// MARK: - Table View
extension SearchHistoryVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = searchHistoryViewModel.searchItems.value.count
        return searchHistoryViewModel.hasMoreData ? count + 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == searchHistoryViewModel.searchItems.value.count && searchHistoryViewModel.hasMoreData  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingIndicatorCell", for: indexPath)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchItemCell", for: indexPath) as? SearchItemCell else {
            return UITableViewCell()
        }
        
        cell.configCell(item: searchHistoryViewModel.searchItems.value[indexPath.row])
        return cell
    }
}

extension SearchHistoryVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.reuseIdentifier == "LoadingIndicatorCell" {
            searchHistoryViewModel.loadMoreResults(query: searchBar.text ?? "")
        }
    }
}
