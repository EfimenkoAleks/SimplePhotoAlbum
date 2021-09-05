//
//  DetailViewModel.swift
//  SimplePhotoAlbum
//
//  Created by user on 03.09.2021.
//

import Foundation

class DetailViewModel {
    private var service: ImageService
    private var url: URL?
    weak var delegate: DetailViewModelDelegate?
    
    init(url: URL?, service: ImageService = DIContainer.default.imageService) {
        self.service = service
        self.url = url
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    
    func downloadPhoto() {
        guard let url = self.url else { return }
        self.service.downloadImage(url) { [weak self] (result) in
            guard let self = self , let data = result else { return }
            self.delegate?.didDownloadPhoto(image: data)
        }
    }
}
