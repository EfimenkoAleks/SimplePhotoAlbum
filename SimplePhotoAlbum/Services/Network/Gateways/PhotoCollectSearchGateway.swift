//
//  PhotoCollectSearchGateway.swift
//  SimplePhotoAlbum
//
//  Created by user on 02.02.2022.
//

import Foundation

protocol PhotoCollectSearchGatewayProtocol: Service {
    var photoSearchList: [PhotoListSearchRequest.PhotoListSearchResponseItem] { get }
}

class PhotoCollectSearchGateway {
    
    private let apiService: APIService
    
    internal var state: ServiceState = .initial
    
    private(set) var photoSearchList = [PhotoListSearchRequest.PhotoListSearchResponseItem]()
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    private func load(page: Int, search: String, completionHandler: @escaping (ServiceState) -> Void) {
        guard self.state != .loading else { return }
        self.photoSearchList = []
        self.state = .loading
        completionHandler(self.state)
        self.apiService.searchListPhoto(photo: page, search: search) { [weak self] (result) in
            guard let self = self else {
                completionHandler(.error)
                return
            }
            guard let list = try? result.get() else {
                self.state = .error
                completionHandler(self.state)
                return
            }
            
            self.photoSearchList.append(list)
            self.state = .loaded
            completionHandler(self.state)
        }
    }
}

extension PhotoCollectSearchGateway: PhotoCollectSearchGatewayProtocol {
    func reload(with hage: Int, params: [String : Any]?, completionHandler: @escaping (ServiceState) -> Void) {
        guard let parametrs = params else { return }
        let search = parametrs["search"] as? String ?? ""
        load(page: hage, search: search, completionHandler: completionHandler)
    }
}
