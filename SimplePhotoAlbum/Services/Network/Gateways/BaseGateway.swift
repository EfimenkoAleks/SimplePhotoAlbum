//
//  BaseGateway.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.02.2022.
//

import Foundation
import Alamofire

class BaseGateway {
    
    private let encoder = JSONEncoder()
    
    internal var state: ServiceState = .initial
    
    init() {
        self.state = .loaded
    }
}

extension BaseGateway: NetworkService {
    
    func reload(completionHandler: (ServiceState) -> Void) {}
    
    func GET(
        url: String,
        token: String?,
        params: [String: Any]?,
        completionHandler: @escaping (NetworkServiceResponse) -> Void
    ) {
        
        let afurl = AppConfig.baseURL + "photos?client_id=\(AppConfig.token)&order_by=ORDER&page=\(1)&per_page=30"
        AF.request(afurl)
            .validate()
            .responseDecodable(of: PhotoListRequest.PhotoListResponseItem.self) { (response) in
                
                switch response.response?.statusCode {
                case 200:
                    DispatchQueue.main.async {
                        completionHandler(
                            NetworkServiceResponse(
                                data: response.data,
                                error: response.error,
                                headers: (response.response)?.allHeaderFields ?? [:]
                            )
                        )
                    }
                    
                case .none:
                    completionHandler(
                        NetworkServiceResponse(
                            data: response.data,
                            error: response.error,
                            headers: (response.response)?.allHeaderFields ?? [:]
                        )
                    )
                    
                case .some(_):
                    completionHandler(
                        NetworkServiceResponse(
                            data: response.data,
                            error: response.error,
                            headers: (response.response)?.allHeaderFields ?? [:]
                        )
                    )
                }
            }
    }
    
//    func POST(
//        url: String,
//        token: String?,
//        params: [String: Any]?,
//        completionHandler: @escaping (NetworkServiceResponse) -> Void
//    ) {
//
//        var headers: HTTPHeaders = [
//            "content-type": "application/json"
//        ]
//
//        if let token = token {
//            headers["x-auth-token"] = token
//        }
//
//        var afParams: [String: Any] = [:]
//        if let paramss = params {
//            afParams = paramss
//            afParams["client_id"] = token
//        }
//
//        let afUrl = AppConfig.baseURL + url
//
//        AF.request(afUrl, method: .post, parameters: afParams, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
//            DispatchQueue.main.async {
//                completionHandler(
//                    NetworkServiceResponse(
//                        data: response.data,
//                        error: response.error,
//                        headers: (response.response)?.allHeaderFields ?? [:]
//                    )
//                )
//            }
//        }
//    }
}
