//
//  LandscapeLayout.swift
//  SimplePhotoAlbum
//
//  Created by user on 05.09.2021.
//

import UIKit

class LandscapeLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .vertical
        let height: CGFloat = UIScreen.main.bounds.height
        let aspectRatio: CGFloat = 1.75
        let width = (height * aspectRatio) + 25
        
        self.itemSize = CGSize(width: width, height: height)
        self.minimumLineSpacing = 2.0
        self.minimumInteritemSpacing = 2.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        guard let collectionView = collectionView,
              collectionView.numberOfSections != 0 else { return }
    }
}
