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
    
    init(url: URL?, service: ImageService = BaseFetcher.shared.imageService) {
        self.service = service
        self.url = url
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    
    func downloadPhoto() {
        guard let url = self.url else { return }
        self.service.downloadImage(url: url) { [weak self] (result) in
            guard let self = self , let data = result else { return }
            DispatchQueue.main.async {
                self.delegate?.didDownloadPhoto(image: data)
            }
        }
    }
}
