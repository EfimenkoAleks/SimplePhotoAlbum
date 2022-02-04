//
//  NetWorkService.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.02.2022.
//

import Foundation

struct NetworkServiceResponse {
    let data: Data?
    let error: Error?
    let headers: [AnyHashable: Any]
}

struct InvalidTokenError: Codable {
    let status: String
    let reason: String
    
    func isInvalidToken() -> Bool {
        return status == "failed"
    }
}

extension InvalidTokenError: Equatable {}

extension NetworkServiceResponse {
    
    func isInvalidToken() -> Bool {
        guard let data = self.data else {
            return false
        }
        let decoder = JSONDecoder()
        
        guard let error = try? decoder.decode(InvalidTokenError.self, from: data) else {
            return false
        }
        
        return error.isInvalidToken()
    }
    
    func decode<T: Decodable>() -> Result<T, Error> {
        let decoder = JSONDecoder()
        do {
            let model = try decoder.decode(T.self, from: self.data ?? Data())
            return .success(model)
        } catch let error {
            return.failure(error)
        }
    }
}

extension Data {
    func decode() -> [String: Any] {
        let obj = try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed)
        return obj as? [String: Any] ?? [:]
    }
    
    func decode<T: Decodable>(type: T.Type) -> T? {
        let obj = try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed)
        
        guard
            let dict = obj as? [String: Any],
            let data = dict.asData() else {
            return nil
        }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    func asData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
    }
}

protocol NetworkService: Service {
//    @discardableResult
    func GET(
        url: String,
        token: String?,
        params: [String: Any]?,
        completionHandler: @escaping (NetworkServiceResponse) -> Void
    )
    
//    func POST(
//        url: String,
//        token: String?,
//        params: [String: Any]?,
//        completionHandler: @escaping (NetworkServiceResponse) -> Void
//    )
}

