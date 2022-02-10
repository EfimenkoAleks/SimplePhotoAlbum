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
    
    private func load(page: Int, completionHandler: @escaping (ServiceState) -> Void) {
        guard self.state != .loading else { return }
        self.photoList = []
        self.state = .loading
        completionHandler(self.state)
        self.apiService.getListPhoto(photo: page) { [weak self] (result) in
            guard let strongSelf = self else {
                completionHandler(.error)
                return
            }
            guard let list = try? result.get() else {
                strongSelf.state = .error
                completionHandler(strongSelf.state)
                return
            }
            
            strongSelf.photoList = list
            strongSelf.state = .loaded
            completionHandler(strongSelf.state)
        }
    }
}

extension PhotoCollectGateway: PhotoCollectGatewayProtocol {
    func reload(with hage: Int, params: [String : Any]?, completionHandler: @escaping (ServiceState) -> Void) {
        self.load(page: hage, completionHandler: completionHandler)
    }
}
