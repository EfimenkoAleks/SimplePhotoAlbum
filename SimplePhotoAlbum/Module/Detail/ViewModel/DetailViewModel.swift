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
    private var image: String
    weak var delegate: DetailViewModelDelegate?
    
    init(router: DetailRouterProtocol, url: String, service: ImageService = DIContainer.default.imageService) {
        self.router = router
        self.service = service
        self.image = url
      
//        self.service.downloadImage(url) { (result) in
//
//        }
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    
    func downloadPhoto() {
        self.delegate?.didDownloadPhoto(image: self.image)
    }
}
