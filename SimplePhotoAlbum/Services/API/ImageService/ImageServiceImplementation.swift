//
//  ImageServiceImplementation.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import Foundation

class ImageServiceImplementation {
    
    private var session: URLSession
    var imageCache = NSCache<NSURL, NSData>()
    
    init(session: URLSession) {
        self.session = session
    }
}

extension ImageServiceImplementation: ImageService {
    
     func downloadImage(_ url: URL, result: @escaping ((Data?) -> Void)) {
  
        if let cachedData = self.imageCache.object(forKey: url as NSURL) {
            result(cachedData as Data)
        } else {
        
        let request = URLRequest(url: url)
        let task = self.session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let data = data else {
                    result(nil)
                    return
                }
                
                self.imageCache.setObject(data as NSData, forKey: url as NSURL)
                result(data)
 
            }
        }
        task.resume()
    }
     }
}
