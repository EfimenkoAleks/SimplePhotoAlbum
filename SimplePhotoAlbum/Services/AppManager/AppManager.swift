//
//  AppManager.swift
//  SimplePhotoAlbum
//
//  Created by user on 12.01.2022.
//

import Foundation
import UIKit

class AppManager {
    
    static let shared: AppManager = AppManager()
    
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
        let viewController: AppFlowController = AppFlowController()
        window?.rootViewController = viewController
        viewController.setSelected
    }
    
    func updateHeaders() {
        if let session: Session = authService.session {
            let header: String = "" + session.token
        }
    }
}
