//
//  ImageServiceImplementation.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import Foundation

class ImageServiceImplementation {
    
    private var session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    private func loadImageFromDiskWith(fileName: String) -> Data? {

      let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let filename = URL(string: fileName)?.lastPathComponent ?? fileName
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(filename)
            do {
                let image = try Data(contentsOf: imageUrl)//UIImage(contentsOfFile: imageUrl.path)
                return image
            } catch {
                return nil
            }
        }
        return nil
    }
}

extension ImageServiceImplementation: ImageService {
    
     func downloadImage(_ url: String, result: @escaping ((Data?) -> Void)) {
        
        let fileName = URL(string: url)?.lastPathComponent ?? url
        if self.loadImageFromDiskWith(fileName: fileName) != nil {
            result(self.loadImageFromDiskWith(fileName: fileName)!)
            return
        }
        
        let url = URL(string: url)
        let request = URLRequest(url: url!)
        let task = self.session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                guard let data = data else {
                    result(nil)
                    return
                }
                
                let fileManager = FileManager.default
                let documentDir = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                let localFile = documentDir.appendingPathComponent(fileName)
                
                do {
                    try data.write(to: localFile)
                    print("\(localFile)")
                    result(self.loadImageFromDiskWith(fileName: fileName))
                } catch let error {
                    print("error saving file with error", error)
                }
                
  //              result(UIImage(data: data))
            }
        }
        task.resume()
    }
}
