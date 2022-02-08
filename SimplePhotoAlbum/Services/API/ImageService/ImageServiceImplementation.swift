//
//  ImageServiceImplementation.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class ImageServiceImplementation {
    
    private var session: URLSession

    init(session: URLSession) {
        self.session = session
    }
    
    private func getImage(name: String) -> Data? {
        // swiftlint:disable force_unwrapping
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileName = name
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            return nil
        }
    }
}

extension ImageServiceImplementation: ImageService {
    func downloadImage(url: URL, completionHandler: @escaping (Data?) -> Void) {
        guard self.getImage(name: url.absoluteString.md5()) == nil else {
            completionHandler(self.getImage(name: url.absoluteString.md5()))
            return
        }
        
        let completionBlock: (Data?) -> Void = { image in
            DispatchQueue.main.async {
                completionHandler(image)
            }
        }
        
        let task = self.session.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completionBlock(nil)
                return
            }

            guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil
        
            else {
                completionBlock(nil)
                return
            }

            // swiftlint:disable force_unwrapping
            let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
            let fileName = url.absoluteString.md5()
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                do {
                    try data.write(to: fileURL)
                    completionBlock(data)
                } catch {
                    completionBlock(nil)
                }
            } else if FileManager.default.fileExists(atPath: fileURL.path) {
                completionBlock(data)
            }
        }

        task.resume()
    }
}
