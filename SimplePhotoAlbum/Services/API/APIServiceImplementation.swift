//
//  APIServiceImplementation.swift
//  SimplePhotoAlbum
//
//  Created by user on 02.09.2021.
//

import Foundation

class APIServiceImplementation {
    
    var session: URLSession
    let baseURL = "https://api.unsplash.com/"
    let clientId = "uD2tVqG7FvBiJleWekfsv-Ty5z7clfT9COoxHtvP0rg"

    init(session: URLSession) {
        self.session = session
    }
    
    fileprivate enum Endpoint {
        case feed(Int)
        case search(Int, String)
        
        var path: String {
            switch self {
            case .feed(let page):
                return "photos?client_id=uD2tVqG7FvBiJleWekfsv-Ty5z7clfT9COoxHtvP0rg&order_by=ORDER&page=\(page)&per_page=30"
            case .search(let page, let search):
                return "search/photos?client_id=uD2tVqG7FvBiJleWekfsv-Ty5z7clfT9COoxHtvP0rg&page=\(page)&query=\(search)&per_page=30"
            }
        }
    }
}

extension APIServiceImplementation: APIService {
    
    func searchListPhoto(photo:Int, search: String, completionHandler: @escaping (Result<ResultSearch>) -> Void) {
        
        let str = baseURL + Endpoint.search(photo, search).path
 
        let targetURL = URL(string: str)
        guard let url = targetURL else { return }
        let request = URLRequest(url: url)
        
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
       
        let str = baseURL + Endpoint.feed(photo).path
 
        let targetURL = URL(string: str)
        guard let url = targetURL else { return }
        let request = URLRequest(url: url)
        
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
            print("result(.success(data))")
            result(.success(data))
        }
        task.resume()
    }
    
}
