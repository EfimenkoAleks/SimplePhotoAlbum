//
//  DetailViewModel.swift
//  SimplePhotoAlbum
//
//  Created by user on 03.09.2021.
//

import Foundation

class DetailViewModel {
    private var router: DetailRouterProtocol
    private var service: ImageService
    private var url: URL?
    weak var delegate: DetailViewModelDelegate?
    
    init(router: DetailRouterProtocol, url: URL?, service: ImageService = DIContainer.default.imageService) {
        self.router = router
        self.service = service
        self.url = url
      
//        self.service.downloadImage(url) { (result) in
//
//        }
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    
    func downloadPhoto() {
  //      self.delegate?.didDownloadPhoto(image: self.image)
        guard let url = self.url else { return }
        self.service.downloadImage(url) { [weak self] (result) in
            guard let self = self , let data = result else { return }
            self.delegate?.didDownloadPhoto(image: data)
        }
    }
}
