//
//  HomeViewModel.swift
//  WisdomLeaf
//
//  Created by Atul Gupta on 02/05/23.
//

import Foundation

class HomeViewModel {
    
    //MARK: Callbacks
    var photosCallback: (() -> Void)?
    var errorCallback: ((String) -> Void)?
    
    //MARK: Variables
    var photos: [Photo] = []
    var page: Int = 0
    var paginationLimit: Int = 20
    var pageState: PageState = .idle
    
    func callAsFunction(_ action: HomeActions) {
        switch action {
        case .getPhotos: fetchPhotos()
        }
    }
    
    private func fetchPhotos() {
        let apiService = APIService<[Photo]>()
        let url = APIConstants.photosURL(page: page, limit: paginationLimit)
        
        guard pageState == .idle else { return }
    
        pageState = .loading
        apiService.fetch(from: url) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let photos):
                if self.page == 0 {
                    self.photos = []
                }
                
                if photos.count == self.paginationLimit {
                    self.pageState = .idle
                    self.page += 1
                    
                } else {
                    self.pageState = .finished
                }
                self.photos.append(contentsOf: photos)
                
                DispatchQueue.main.async {
                    self.photosCallback?()
                }
                
            case .failure(let error):
                self.pageState = .idle
                DispatchQueue.main.async {
                    self.errorCallback?((error as NSError).localizedDescription)
                }
            }
        }
    }
}
