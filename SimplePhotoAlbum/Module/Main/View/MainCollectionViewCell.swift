//
//  MainCollectionViewCell.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    let service = DIContainer.default.imageService
    @IBOutlet weak var imageImageView: UIImageView!
    
    func configur(model: String) {
        self.imageImageView.image = UIImage(named: model)
    }
    
//    func configur(model: URL?) {
//        guard let url = model else { return }
//
//        service.downloadImage(url) { (result) in
//            guard let image = result else { return }
//            DispatchQueue.main.async {
//                self.imageImageView.image = UIImage(data: image)
//            }
//        }
//    }
}
