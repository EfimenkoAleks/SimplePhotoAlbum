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
  
    func GET(
        params: [String: Any],
        completionHandler: @escaping (NetworkServiceResponse) -> Void
    ) {
         let baseUrl = params["baseURL"] as? String ?? ""
              let url = params["url"] as? String ?? ""
              let token = params["client_id"] as? String ?? ""
              let order = params["order_by"] as? String ?? ""
              let page = params["page"] as? String ?? ""
        let query = params["query"] as? String ?? ""
        let pageCount = params["per_page"] as? String ?? ""
        
        let afurl = baseUrl + url + token + order + page + query + pageCount
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
