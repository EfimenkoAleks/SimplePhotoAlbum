//
//  DataLoadOperation.swift
//  SimplePhotoAlbum
//
//  Created by user on 04.02.2022.
//

import Foundation

class DataLoadOperation: Operation {
  // 1
  var emojiRating: ImageModel?
  var loadingCompleteHandler: ((ImageModel) -> Void)?
    private let imageService: ImageService
  
  private let _emojiRating: ImageModel
  
  // 2
  init(
    _ emojiRating: ImageModel,
       imageService: ImageService = BaseFetcher.shared.imageService
  ) {
    _emojiRating = emojiRating
      self.imageService = imageService
  }
  
  // 3
  override func main() {
    
      // 1
      if isCancelled { return }
          
      // 2 fetch
//      let randomDelayTime = Int.random(in: 500..<2000)
//      usleep(useconds_t(randomDelayTime * 1000))
      
      self.imageService.downloadImage(url: _emojiRating.url) { [weak self] (result) in
          guard let data = result,
                let url = self?._emojiRating.url
          else { return }
          let image = ImageModel(url: url)
          self?.emojiRating = image
      }

      // 3
      if isCancelled { return }

      // 4
  //    emojiRating = _emojiRating

      // 5
      if let loadingCompleteHandler = loadingCompleteHandler {
          DispatchQueue.main.async { [weak self] in
              guard let model = self?.emojiRating else { return }
              loadingCompleteHandler(model)
        }
      }
  }
}
