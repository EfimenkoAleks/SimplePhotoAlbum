//
//  AppManager.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation
import UIKit

extension NSNotification.Name {
    static let kNeadUpdateCollection: NSNotification.Name = .init("kNeadUpdateCollection")
}

class AppManager {
    
    static let shared: AppManager = AppManager()
    
    let appCoordinator: AppFlowController = AppFlowController()
    let authService: AuthService = AuthService(sessionStorage: SessionStorage(storage: Storage()))
    let appInfoService: AppInfoService = AppInfoService(appSettingsStorage: AppSettingsStorage(storage: Storage()))
    let userSettingsService: UserSettinsService = UserSettinsService(userSettingsStorage: UserSettingsStorage(storage: Storage()))
    var preferedLanguage: [String] {
        return [appInfoService.settings.localeCode]
    }
    private var window: UIWindow?
    
    private init() {
        updateHeaders()
        appInfoService.didChangeSettings = { [weak self] in
            self?.updateHeaders()
        }
        
    }
    
    func updateRootVC(_ window: UIWindow?) {
        self.window = window
     //   let viewController: AppFlowController = AppFlowController()
        window?.rootViewController = appCoordinator
        appCoordinator.setSelectedTab()
    }
    
//    func loadFirstData() {
//        let photoCollect = BaseFetcher.shared.photoService
//        photoCollect.reload(with: ) { state in
//            if state == .loaded {
//                NotificationCenter.default.post(name: .kNeadUpdateCollection, object: nil)
//            }
//        }
//    }
    
    func updateHeaders() {
        if let session: Session = authService.session {
            let header: String = "" + session.token
        }
    }
}
