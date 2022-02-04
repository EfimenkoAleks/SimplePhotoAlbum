//
//  Request.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.02.2022.
//

import Foundation

public class TargetRequest {
    let procedure: String
    let params: [String: Any]
    
    init(procedure: String, params: [String: Any]) {
        self.procedure = procedure
        self.params = params
    }
    
    init(data: Data) {
        let dict = data.decode()
        
        let procedure = dict["proc"] as? String
        let params = dict["params"] as? [String: Any]
        
        self.procedure = procedure ?? ""
        self.params = params ?? [:]
    }
    
    func asData() -> Data? {
        var target: [String: Any] = [:]
        target["proc"] = self.procedure
        target["params"] = self.params
        return try? JSONSerialization.data(withJSONObject: target, options: .prettyPrinted)
    }
}

protocol Request: Encodable {
    var method: String { get }
    var params: [String: Any] { get }
}

extension Request {
    func translateParams() -> Data? {
        let targetRequest = TargetRequest(procedure: self.method, params: params)
        return targetRequest.asData()
    }
}
