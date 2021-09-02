//
//  ImageService.swift
//  SimplePhotoAlbum
//
//  Created by user on 01.09.2021.
//

import UIKit

protocol ImageService {
    func downloadImage(_ url: URL, result: @escaping ((Data?) -> Void))
}
