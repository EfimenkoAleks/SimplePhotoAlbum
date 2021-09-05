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
    private var searchPhotos: [ListPhotos]
    //    private var testArray: [String]
    private var images: [ImageModel]
    private var searchImages: [Data]
    private var dataSource: [ListPhotos]
    private let service: APIService
    private let imageService: ImageService
    private var numberPage: Int
    private var searchText: String
    
    init(router: MainRouterProtocol,
         service: APIService = DIContainer.default.apiService,
         imageService: ImageService = DIContainer.default.imageService
    ) {
        self.router = router
        self.photos = []
        self.searchPhotos = []
        self.numberPage = 0
        self.searchText = ""
        self.images = []
        self.searchImages = []
        self.dataSource = []
        self.imageService = imageService
        self.service = service
        //       self.testArray = ["lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon", "lilo", "lis", "minon"]
        
        self.preload()
    }
    
}

extension MainViewModel: MainViewModelProtocol {
    var countItem: Int {
        return self.images.count
    }
    
    func itemForDidSelect(index: Int) -> URL? {
       let url = self.images[index].url
        let sort = self.dataSource.filter({$0.urls?.small == url})
        return sort.first?.urls?.small
        //    return self.photos[index]
    }
    
    func itemForCollection(index: Int) -> ImageModel {
        return self.images[index]
        //        return self.testArray[index]
    }
    
    func reloadDataSource() {
        self.dataSource = []
        self.images = []
        self.numberPage = 0
        self.delegate?.didFetchingData()
    }
    
//    func loadPhoto(index: Int) {
//        let urlsImage = self.dataSource.compactMap({$0.urls?.small})
//
////        if index == urlsImage.count - 1 {
////            return
////        }
//        self.imageService.downloadImage(urlsImage[index]) { (rezult) in
//            guard let data = rezult else { return }
//            self.images.append(data)
//
//            DispatchQueue.main.async {
//                self.delegate?.didFetchingData()
//            }
//        }
//    }
    
//    func searchLoadPhoto(index: Int) {
//        let urlsImage = self.dataSource.compactMap({$0.urls?.small})
//        self.imageService.downloadImage(urlsImage[index]) { (rezult) in
//            guard let data = rezult else { return }
//            self.images.append(data)
//        }
//    }
    
    func listPhoto() {
        self.numberPage += 1
        
        self.service.getListPhoto(photo: self.numberPage) { [weak self] (respons) in
            guard let self = self else { return }
            switch respons {
            case .success(let model):
               
                self.dataSource += model
                let urlsImage = model.compactMap({$0.urls?.small})
                let group = DispatchGroup()
                
                urlsImage.forEach { [weak self] (item) in
                    guard let self = self else { return }
                    group.enter()
                    self.imageService.downloadImage(item) { (result) in
                        guard let data = result else { return }
                        let image = ImageModel(url: item, image: data)
                        self.images.append(image)
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    self.delegate?.didFetchingData()
                }
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchListPhoto(search: String) {
        self.numberPage += 1
        self.service.searchListPhoto(photo: self.numberPage, search: search) { [weak self] (respons) in
            guard let self = self else { return }
            
            switch respons {
            case .success(let model):
                guard let modelPage = model.totalPages else { return }
                if self.numberPage > modelPage {
                    return
                }
                guard let list = model.results else { return }
                
                self.dataSource += list
                
                let urlsImage = list.compactMap({$0.urls?.small})
                let group = DispatchGroup()
                
                urlsImage.forEach { [weak self] (item) in
                    guard let self = self else { return }
                    group.enter()
                    self.imageService.downloadImage(item) { (result) in
                        guard let data = result else { return }
                        let image = ImageModel(url: item, image: data)
                        self.images.append(image)
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    self.delegate?.didFetchingData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func preload() {
        self.reloadDataSource()
        self.numberPage += 1
        
        self.service.getListPhoto(photo: self.numberPage) { [weak self] (respons) in
            guard let self = self else { return }
            switch respons {
            case .success(let model):
               
                self.dataSource += model
                let urlsImage = self.dataSource.compactMap({$0.urls?.small})
                let group = DispatchGroup()
                
                urlsImage.forEach { [weak self] (item) in
                    guard let self = self else { return }
                    group.enter()
                    self.imageService.downloadImage(item) { (result) in
                        guard let data = result else { return }
                        let image = ImageModel(url: item, image: data)
                        self.images.append(image)
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    self.delegate?.didFetchingData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func preloadSearch(search: String) {
        self.reloadDataSource()
        self.numberPage += 1
        
        self.service.searchListPhoto(photo: self.numberPage, search: search) { [weak self] (respons) in
            guard let self = self else { return }
            switch respons {
            case .success(let model):
    
                guard let list = model.results else { return }
                
                self.dataSource += list
                
                let group = DispatchGroup()
                
                let urlsImage = self.dataSource.compactMap({$0.urls?.small})
                urlsImage.forEach { [weak self] (item) in
                    guard let self = self else { return }
                    group.enter()
                    self.imageService.downloadImage(item) { (result) in
                        guard let data = result else { return }
                        let image = ImageModel(url: item, image: data)
                        self.images.append(image)
                        group.leave()
                    }
                }
                group.notify(queue: .main) {
                    self.delegate?.didFetchingData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func routTodetail(model: URL?) {
        self.router.routToDetail(model: model)
    }
}
