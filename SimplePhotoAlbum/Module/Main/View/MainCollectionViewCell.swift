//
//  MainCollectionViewCell.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageImageView: UIImageView!
    
    func configur(model: Data?) {
        guard let image = model  else { return }
        self.imageImageView.image = UIImage(data: image)
    }
}
