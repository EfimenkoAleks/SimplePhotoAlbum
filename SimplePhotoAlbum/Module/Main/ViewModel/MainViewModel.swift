//
//  MainViewModel.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import Foundation

class MainViewModel {
//    private var router: MainRouterProtocol
    weak var delegate: MainViewModelDelegate?
    private var images: [URL]
    private var dataSource: [PhotoListRequest.PhotoListResponseItem]
    private let imageService: ImageService
    private var numberPage: Int
    private var searchText: String
    private var fetcher: PhotoCollectGatewayProtocol
    
    init(
         imageService: ImageService = BaseFetcher.shared.imageService,
         fetcher: PhotoCollectGatewayProtocol = BaseFetcher.shared.photoService
    ) {
        self.fetcher = fetcher
  //      self.router = router
        self.numberPage = 0
        self.searchText = ""
        self.images = []
        self.dataSource = []
        self.imageService = imageService
        
        fetchData()
    }
    
}

extension MainViewModel: MainViewModelProtocol {
    
    var countItem: Int {
        return self.dataSource.count
    }
    
    func fetchOnPhoto() {
        
    }
    
    func itemForDidSelect(index: Int) -> URL? {
        let url = self.images[index]
        let sort = self.dataSource.filter({$0.urls?.small == url})
        return sort.first?.urls?.full
    }
    
    func itemForCollection(index: Int) -> URL {
        return self.images[index]
    }
    
    func reloadDataSource() {
        self.dataSource = []
        self.images = []
        self.numberPage = 0
        self.delegate?.didFetchingData()
    }
    
    private func fetchData() {
        reloadDataSource()
        numberPage += 1
        fetcher.reload(with: numberPage, params: nil) { [weak self] (state) in
            if state == .loaded {
                self?.ubdateDataSource()
            }
        }
    }
    
    private func ubdateDataSource() {
        
        dataSource = fetcher.photoList
        
        let urlsImage = dataSource.compactMap({$0.urls?.small})
        images = urlsImage
        //        let group = DispatchGroup()
        //
        //        urlsImage.forEach { [weak self] (item) in
        //            guard let self = self else { return }
        //            group.enter()
        //            self.imageService.downloadImage(item) { (result) in
        //                guard let data = result else { return }
        //                let image = ImageModel(url: item, image: data)
        //                self.images.append(image)
        //                group.leave()
        //            }
        //        }
        //        group.notify(queue: .main) {
        self.delegate?.didFetchingData()
        //        }
    }
    
    func neadLoadMore() {
        numberPage += 1
        
        fetcher.reload(with: numberPage, params: nil) { [weak self] (state) in
            if state == .loaded {
                if let list = self?.fetcher.photoList {
                    self?.dataSource += list
                    
                    let urlsImage = list.compactMap({$0.urls?.small})
                    self?.images += urlsImage
                    self?.delegate?.didFetchingData()
                } else {
                    self?.dataSource += []
                    
                }
            }
        }
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
  //      AppManager.shared.appCoordinator.firstCoordinator?.showDetailController(url: model)
    }
}
