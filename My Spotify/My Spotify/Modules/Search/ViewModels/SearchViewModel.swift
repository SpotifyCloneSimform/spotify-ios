//
//  SearchViewModel.swift
//  My Spotify
//
//  Created by Krunal Patel on 06/07/23.
//

class SearchViewModel {
    
    // MARK: - Vars & Lets
    let errorMessage = Dynamic<String>("")
    let categories = Dynamic<[Category]>([])
    
    // MARK: - Methods
    func fetchCategories() {
        APIManager.shared.call(type: .categories) { [weak self] (result: Result<CategoriesResponse, CustomError>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                if let items = response.categories?.items {
                    self.categories.value = items
                }
            case .failure(let error):
                self.errorMessage.value = error.body
                break
            }
            
        }
    }
}
