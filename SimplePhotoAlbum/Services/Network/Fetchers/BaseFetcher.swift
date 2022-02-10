//
//  BaseFetcher.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.02.2022.
//

import Foundation

class BaseFetcher {
    
    static let shared = BaseFetcher()
    
    private lazy var baseGateway = BaseGateway()
    lazy var apiService: APIService = APIServiceImplementation(networkService: baseGateway)
    lazy var imageService: ImageService = ImageServiceImplementation(session: URLSession.shared)
    
    lazy var photoService: PhotoCollectGatewayProtocol = PhotoCollectGateway(apiService: apiService)
    lazy var photoSearchService: PhotoCollectSearchGatewayProtocol = PhotoCollectSearchGateway(apiService: apiService)
}
