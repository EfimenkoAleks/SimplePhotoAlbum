//
//  Extension+CollectionViewCell.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

public extension UICollectionView {
   
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: identifier ?? cellId)
    }
    
    func dequeueCell<T: UICollectionViewCell>(withType type: UICollectionViewCell.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T
    }
}

public extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}
