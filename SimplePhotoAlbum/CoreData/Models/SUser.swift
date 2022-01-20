import Foundation
import CoreData

@objc(SUser)
open class SUser: _SUser, DBStorableObject {
	// Custom logic goes here.
    
    public func setupWithDictionary(_ aData: [String: Any], context aContext: NSManagedObjectContext) {
    
        name = aData["name"] as? String
        email = aData["email"] as? String
        city = aData["city"] as? String
        countryCode = aData["countryCode"] as? String
        currencyCode = aData["currencyCode"] as? String
        identifier = aData["identifier"] as? Int64 ?? 0
        localeCode = aData["localeCode"] as? String
        phone = aData["phone"] as? String
        zip = aData["zip"] as? String
    
        if let str: String = aData["created_at"] as? String {
            dataCreated = DateFormatter.iso8601.date(from: str)
        }
        if let str: String = aData["updated_at"] as? String {
            dateUpdate = DateFormatter.iso8601.date(from: str)
        }
    }
}
