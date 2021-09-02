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
    private var testArray: [String]
    private let service: APIService
    private var numberPage: Int
    private var searchText: String
    
    init(router: MainRouterProtocol,
         service: APIService = DIContainer.default.apiService
         ) {
        self.router = router
        self.photos = []
        self.searchPhotos = []
        self.numberPage = 0
        self.searchText = ""
        self.service = service
        self.testArray = ["lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon"]
        
//        self.listPhoto(pageNumber: 1)
        
    }
}

extension MainViewModel: MainViewModelProtocol {
    var countItem: Int {
   //     return self.photos.count
        return self.testArray.count
    }
    
    var searchCountItem: Int {
//             return self.searchPhotos.count
             return self.testArray.count
    }
    
    func itemForCollection(index: Int) -> String {
    //    return self.photos[index]
        return self.testArray[index]
    }
    
    func searchItemForCollection(index: Int) -> String {
 //       return self.searchPhotos[index]
        return self.testArray[index]
    }
    
    func filterContentForSearchText(_ searchText: String) {
        self.searchText = searchText
        self.numberPage = 0
        self.searchListPhoto()
    }
    
    func goListPhoto() {
        self.numberPage = 0
        self.listPhoto()
    }
    
    func listPhoto() {
        self.numberPage += 1
        self.service.getListPhoto(photo: self.numberPage) { (respons) in
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
    }
    func searchListPhoto() {
        self.numberPage += 1
        self.service.searchListPhoto(photo: self.numberPage, search: self.searchText) { (respons) in
            switch respons {
            case .success(let model):
                let list = model.results
                guard let list1 = list else { return }
                self.searchPhotos += list1
                DispatchQueue.main.async {
                    self.delegate?.didFetchingData()
                }
            case .failure(let error):
            print(error.localizedDescription)
            }
        }
    }
}
