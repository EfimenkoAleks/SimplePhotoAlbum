//
//  DetailViewController.swift
//  SimplePhotoAlbum
//
//  Created by user on 03.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModelProtocol!
    var viewScroll: ImageScrollView?
    
    let loadIndikator : UIActivityIndicatorView = {
        let ind = UIActivityIndicatorView(style: .large)
        ind.backgroundColor = .lightGray
        ind.alpha = 0.5
        ind.translatesAutoresizingMaskIntoConstraints = false
        
        return ind
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLoadIndikator()
        self.loadIndikator.startAnimating()
        self.viewModel.delegate = self
        self.title = "Photo"
        self.view.backgroundColor = .systemOrange
        self.viewModel.downloadPhoto()
    }
    
//    override func viewWillLayoutSubviews() {
//        self.setupLoadIndikator()
//        self.loadIndikator.startAnimating()
//    }
    
    private func setupLoadIndikator() {
        
        self.view.addSubview(loadIndikator)
        
        loadIndikator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        loadIndikator.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        loadIndikator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        loadIndikator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func addViewScroll() {
        
        viewScroll?.translatesAutoresizingMaskIntoConstraints = false
        viewScroll?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        viewScroll?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewScroll?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        viewScroll?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func setupScroll(image: Data) {
        self.viewScroll = ImageScrollView(frame: self.view.bounds)
        self.view.addSubview(self.viewScroll!)
        self.addViewScroll()
        guard let image = UIImage(data: image) else { return }
        self.viewScroll?.set(image: image)
       
            self.loadIndikator.stopAnimating()
            self.loadIndikator.removeFromSuperview()
    }

}

extension DetailViewController: DetailViewModelDelegate {
    
    func didDownloadPhoto(image: Data) {
        self.setupScroll(image: image)
    }
}
