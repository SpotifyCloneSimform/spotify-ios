//
//  ViewPodcastViewModel.swift
//  My Spotify
//
//  Created by Devarsh Bhalara on 12/07/23.
//

class ViewPodcastViewModel {
    
    // MARK: - Variables
    var shows = Dynamic<PodcastShowDetail?>(nil)
    var failure = Dynamic<String>("")
    
    func getPodscastProfile(id: String) {
        APIManager.shared.call(type: .getShows(id: id)) { [weak self] (result: Result<PodcastShowDetail, CustomError>) in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let shows):
                self.shows.value = shows
            case .failure(let error):
                self.failure.value = error.body
            }
        }
    }
}
