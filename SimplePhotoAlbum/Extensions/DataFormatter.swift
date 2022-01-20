//
//  DataFormatter.swift
//  SimplePhotoAlbum
//
//  Created by user on 18.01.2022.
//

import Foundation

extension DateFormatter {
    
    static var iso8601: ISO8601DateFormatter = ISO8601DateFormatter()
    static var short: DateFormatter = {
        let formater: DateFormatter = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy"
        return formater
    }()
    static var base: DateFormatter = {
        let formater: DateFormatter = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formater
    }()
}

extension Date {
    func localDate() -> Date {
        let nowUTC: Date = Date()
        let timeZoneOfSet: Double = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate: Date = Calendar.current.date(byAdding: .second, value: Int(timeZoneOfSet), to: nowUTC) else {
            return Date()
        }
        return localDate
    }
    
    func toString() -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale  = Locale(identifier: AppManager.shared.appInfoService.settings.localeCode)
        formatter.dateFormat = "dd MM yyyy"
        return formatter.string(from: self)
    }
}
