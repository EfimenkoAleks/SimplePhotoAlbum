//
//  MainCollectionViewCell.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageImageView: UIImageView!
    
    func configur(model: Data) {
        self.imageImageView.image = UIImage(data: model)
    }
}
