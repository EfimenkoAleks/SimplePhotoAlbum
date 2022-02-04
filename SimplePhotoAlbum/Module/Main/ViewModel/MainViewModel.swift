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
    private var images: [ImageModel]
    private var dataSource: [PhotoListRequest.PhotoListResponseItem]
//    private let service: APIService
    private let imageService: ImageService
    private var numberPage: Int
    private var searchText: String
    private var fetcher: PhotoCollectGatewayProtocol
    
    init(router: MainRouterProtocol,
 //        service: APIService = DIContainer.default.apiService,
         imageService: ImageService = BaseFetcher.shared.imageService,
         fetcher: PhotoCollectGatewayProtocol = BaseFetcher.shared.photoService
    ) {
        self.fetcher = fetcher
        self.router = router
        self.numberPage = 0
        self.searchText = ""
        self.images = []
        self.dataSource = []
        self.imageService = imageService
 //       self.service = service
 //       self.preload()
        fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(obdateDataSource), name: .kNeadUpdateCollection, object: nil)
    }
    
}

extension MainViewModel: MainViewModelProtocol {
    var countItem: Int {
        return self.images.count
    }
    
    func itemForDidSelect(index: Int) -> URL? {
       let url = self.images[index].url
        let sort = self.dataSource.filter({$0.urls?.small == url})
        return sort.first?.urls?.full
    }
    
    func itemForCollection(index: Int) -> ImageModel {
        return self.images[index]
    }
    
    func reloadDataSource() {
        self.dataSource = []
        self.images = []
        self.numberPage = 0
        self.delegate?.didFetchingData()
    }
    
    private func fetchData() {
        AppManager.shared.loadFirstData()
    }
    
    @objc func obdateDataSource() {
        reloadDataSource()
        dataSource = fetcher.photoList
        
        let urlsImage = dataSource.compactMap({$0.urls?.small})
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
    }

    func listPhoto() {
//        self.numberPage += 1
//
//        self.service.getListPhoto(photo: self.numberPage) { [weak self] (respons) in
//            guard let self = self else { return }
//            switch respons {
//            case .success(let model):
//
//                self.dataSource += model
//                let urlsImage = model.compactMap({$0.urls?.small})
//                let group = DispatchGroup()
//
//                urlsImage.forEach { [weak self] (item) in
//                    guard let self = self else { return }
//                    group.enter()
//                    self.imageService.downloadImage(item) { (result) in
//                        guard let data = result else { return }
//                        let image = ImageModel(url: item, image: data)
//                        self.images.append(image)
//                        group.leave()
//                    }
//                }
//                group.notify(queue: .main) {
//                    self.delegate?.didFetchingData()
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func searchListPhoto(search: String) {
//        self.numberPage += 1
//        self.service.searchListPhoto(photo: self.numberPage, search: search) { [weak self] (respons) in
//            guard let self = self else { return }
//
//            switch respons {
//            case .success(let model):
//                guard let modelPage = model.totalPages else { return }
//                if self.numberPage > modelPage {
//                    return
//                }
//                guard let list = model.results else { return }
//
//                self.dataSource += list
//
//                let urlsImage = list.compactMap({$0.urls?.small})
//                let group = DispatchGroup()
//
//                urlsImage.forEach { [weak self] (item) in
//                    guard let self = self else { return }
//                    group.enter()
//                    self.imageService.downloadImage(item) { (result) in
//                        guard let data = result else { return }
//                        let image = ImageModel(url: item, image: data)
//                        self.images.append(image)
//                        group.leave()
//                    }
//                }
//                group.notify(queue: .main) {
//                    self.delegate?.didFetchingData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func preload() {
//        self.reloadDataSource()
//        self.numberPage += 1
//
//        self.service.getListPhoto(photo: self.numberPage) { [weak self] (respons) in
//            guard let self = self else { return }
//            switch respons {
//            case .success(let model):
//
//                self.dataSource += model
//                let urlsImage = self.dataSource.compactMap({$0.urls?.small})
//                let group = DispatchGroup()
//
//                urlsImage.forEach { [weak self] (item) in
//                    guard let self = self else { return }
//                    group.enter()
//                    self.imageService.downloadImage(item) { (result) in
//                        guard let data = result else { return }
//                        let image = ImageModel(url: item, image: data)
//                        self.images.append(image)
//                        group.leave()
//                    }
//                }
//                group.notify(queue: .main) {
//                    self.delegate?.didFetchingData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func preloadSearch(search: String) {
//        self.reloadDataSource()
//        self.numberPage += 1
//
//        self.service.searchListPhoto(photo: self.numberPage, search: search) { [weak self] (respons) in
//            guard let self = self else { return }
//            switch respons {
//            case .success(let model):
//
//                guard let list = model.results else { return }
//
//                self.dataSource += list
//
//                let group = DispatchGroup()
//
//                let urlsImage = self.dataSource.compactMap({$0.urls?.small})
//                urlsImage.forEach { [weak self] (item) in
//                    guard let self = self else { return }
//                    group.enter()
//                    self.imageService.downloadImage(item) { (result) in
//                        guard let data = result else { return }
//                        let image = ImageModel(url: item, image: data)
//                        self.images.append(image)
//                        group.leave()
//                    }
//                }
//                group.notify(queue: .main) {
//                    self.delegate?.didFetchingData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func routTodetail(model: URL?) {
        self.router.routToDetail(model: model)
    }
}
