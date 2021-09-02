//
//  MainViewModel.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import Foundation

class MainViewModel {
    private var router: MainRouterProtocol
    weak var delegate: MainViewModelDelegate?
    private var photos: [ListPhotos]
    private var searchPhotos: [OneResultSearch]
    let service: APIService
    
    init(router: MainRouterProtocol,
         service: APIService = DIContainer.default.apiService
         ) {
        self.router = router
        self.photos = []
        self.searchPhotos = []
        self.service = service
        
        self.searchPhoto(pageNumber: 1, search: "office")
        
    }
}

extension MainViewModel: MainViewModelProtocol {
    var countItem: Int {
        return self.photos.count
    }
    
    func itemForCollection(index: Int) -> ListPhotos {
        return self.photos[index]
    }
    
    func searchPhoto(pageNumber: Int, search: String) {
        self.service.getListPhoto(photo: pageNumber) { (respons) in
            switch respons {
                        case .success(let model):
  //                          print("\(model)")
                            let list = model
                            self.photos += list
                            DispatchQueue.main.async {
                                self.delegate?.didFetchingData()
                            }
                        case .failure(let error):
                        print(error.localizedDescription)
                        }
        }
        
//        self.service.searchListPhoto(photo: pageNumber, search: "office") { (respons) in
//            switch respons {
//            case .success(let model):
//                let list = model.results
//                guard let list1 = list else { return }
//                self.photos += list1
//                DispatchQueue.main.async {
//                    self.delegate?.didFetchingData()
//                }
//            case .failure(let error):
//            print(error.localizedDescription)
//            }
//        }
    }
}
