//
//  MainCollectionViewCell.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    let imageService = BaseFetcher.shared.imageService
    @IBOutlet weak var imageImageView: UIImageView!
    
    func configur(model: URL) {

        imageService.downloadImage(url: model) { image in
            guard let image = image else { return }
            self.imageImageView.image = UIImage(data: image)
        }
    }
}
