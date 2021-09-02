//
//  APIServiceImplementation.swift
//  SimplePhotoAlbum
//
//  Created by user on 02.09.2021.
//

import Foundation

class APIServiceImplementation {
    
    var session: URLSession
    let baseURL: URL = URL(string: "https://api.unsplash.com")!
    let clientId = "uD2tVqG7FvBiJleWekfsv-Ty5z7clfT9COoxHtvP0rg"
    // https://api.unsplash.com/photos?client_id=uD2tVqG7FvBiJleWekfsv-Ty5z7clfT9COoxHtvP0rg&order_by=ORDER&page=1&per_page=30
    
    init(session: URLSession) {
        self.session = session
    }
    
    fileprivate enum Endpoint {
        case feed(Int)
        case search(Int, String)
        
        var path: String {
            switch self {
            case .feed(let page):
                return "photos?order_by=ORDER&page=\(page)&per_page=30"
            case .search(let page, let search):
                return "search/photos?page=\(page)&query=\(search)"
            }
        }
    }
}

extension APIServiceImplementation: APIService {
    
    func searchListPhoto(photo:Int, search: String, completionHandler: @escaping (Result<ResultSearch>) -> Void) {
        
        let targetURL = baseURL.appendingPathComponent(Endpoint.feed(photo).path)
        
        var request = URLRequest(url: targetURL)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
        
        self.load(request) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let parsedResult: ResultSearch = try JSONDecoder().decode(ResultSearch.self, from: data)
                    completionHandler(.success(parsedResult))
                } catch let error {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    func getListPhoto(photo:Int, completionHandler: @escaping (Result<[ListPhotos]>) -> Void) {
        
        let targetURL = baseURL.appendingPathComponent(Endpoint.feed(photo).path)
        var request = URLRequest(url: targetURL)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
        
        self.load(request) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let parsedResult: [ListPhotos] = try JSONDecoder().decode([ListPhotos].self, from: data)
                    completionHandler(.success(parsedResult))
                } catch let error {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    private func load(_ request: URLRequest, result: @escaping ((Result<Data>) -> Void)) {
        
        let task = self.session.dataTask(with: request) { (data, _, error) in
            guard let data = data else {
                result(.failure(APIError.noData))
                return
            }
            if let error = error {
                result(.failure(error))
                return
            }
            result(.success(data))
        }
        task.resume()
    }
    
}
