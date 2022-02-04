//
//  PhotoCollectGateway.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.02.2022.
//

import Foundation

protocol PhotoCollectGatewayProtocol: Service {
    var photoList: [PhotoListRequest.PhotoListResponseItem] { get }
}

class PhotoCollectGateway {
    
    private let apiService: APIService
    
    internal var state: ServiceState = .initial
    
    private(set) var photoList = [PhotoListRequest.PhotoListResponseItem]()
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    private func load(completionHandler: @escaping (ServiceState) -> Void) {
        guard self.state != .loading else { return }
        self.photoList = []
        self.state = .loading
        completionHandler(self.state)
        self.apiService.getListPhoto(photo: 1) { [weak self] (result) in
            guard let self = self else {
                completionHandler(.error)
                return
            }
            guard let list = try? result.get() else {
                self.state = .error
                completionHandler(self.state)
                return
            }
            
            self.photoList += list
            self.state = .loaded
            completionHandler(self.state)
        }
    }
}

extension PhotoCollectGateway: PhotoCollectGatewayProtocol {
    func reload(completionHandler: @escaping (ServiceState) -> Void) {
        self.load(completionHandler: completionHandler)
    }
}

