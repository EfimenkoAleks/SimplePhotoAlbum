//
//  APIServiceImplementation.swift
//  SimplePhotoAlbum
//
//  Created by user on 02.09.2021.
//

import Foundation

class APIServiceImplementation {
   
    private var token: String? = AppConfig.token
    internal weak var delegate: APIServiceDelegate?
    
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
//    fileprivate enum Endpoint {
//        case feed(String, Int)
//        case search(String, Int, String)
//
//        var path: String {
//            switch self {
//            case .feed(let clientId, let page):
//                return "photos?client_id=\(clientId)&order_by=ORDER&page=\(page)&per_page=30"
//            case .search(let clientId, let page, let search):
//                return "search/photos?client_id=\(clientId)&page=\(page)&query=\(search)&per_page=30"
//            }
//        }
//    }
}

extension APIServiceImplementation: APIService {
    func getListPhoto(photo: Int, completionHandler: @escaping (Result<[PhotoListRequest.PhotoListResponseItem], Error>) -> Void) {
        
        let url: String = "photos"
        var params: [String: String] = [:]
        params["client_id"] = AppConfig.token
        params["order_by"] = "ORDER"
        params["page"] = photo.description
        params["per_page"] = "30"
      
        networkService.GET(url: url, token: token, params: params) { result in
            if result.isInvalidToken() {
                self.token = nil
                self.delegate?.tokenIsInvalid()
            }
            
            completionHandler(result.decode())
        }
    }
    
    func searchListPhoto(photo: Int, search: String, completionHandler: @escaping (Result<PhotoListSearchRequest.PhotoListSearchResponseItem, Error>) -> Void) {
        
        let url: String = "search/photos"
        let params: [String: String] = [
            "page": photo.description,
            "query": search,
            "per_page": "30"
        ]
        
        networkService.GET(url: url, token: token, params: params) { result in
            if result.isInvalidToken() {
                self.token = nil
                self.delegate?.tokenIsInvalid()
            }
            
            completionHandler(result.decode())
        }
    }
    
    
}

//extension APIServiceImplementation: APIService {
//
//    func searchListPhoto(photo:Int, search: String, completionHandler: @escaping (Result<ResultSearch>) -> Void) {
//
//        let str = baseURL + Endpoint.search(clientId, photo, search).path
//
//        let targetURL = URL(string: str)
//        guard let url = targetURL else { return }
//        let request = URLRequest(url: url)
//
//        self.load(request) { (result) in
//
//            switch result {
//            case .success(let data):
//                do {
//                    let parsedResult: ResultSearch = try JSONDecoder().decode(ResultSearch.self, from: data)
//                    completionHandler(.success(parsedResult))
//                } catch let error {
//                    completionHandler(.failure(error))
//                }
//            case .failure(let error):
//                completionHandler(.failure(error))
//            }
//        }
//    }
//
//    func getListPhoto(photo:Int, completionHandler: @escaping (Result<[ListPhotos]>) -> Void) {
//
//        let str = baseURL + Endpoint.feed(clientId, photo).path
//
//        let targetURL = URL(string: str)
//        guard let url = targetURL else { return }
//        let request = URLRequest(url: url)
//
//        self.load(request) { (result) in
//
//            switch result {
//            case .success(let data):
//                do {
//                    let parsedResult: [ListPhotos] = try JSONDecoder().decode([ListPhotos].self, from: data)
//
//                    completionHandler(.success(parsedResult))
//                } catch let error {
//                    completionHandler(.failure(error))
//                }
//            case .failure(let error):
//                completionHandler(.failure(error))
//            }
//        }
//    }
//
//    private func load(_ request: URLRequest, result: @escaping ((Result<Data>) -> Void)) {
//
//        let task = self.session.dataTask(with: request) { (data, _, error) in
//            guard let data = data else {
//                result(.failure(APIError.noData))
//                return
//            }
//            if let error = error {
//                result(.failure(error))
//                return
//            }
//            print("result(.success(data))")
//            result(.success(data))
//        }
//        task.resume()
//    }
//
//}
