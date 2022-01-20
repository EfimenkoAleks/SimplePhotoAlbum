// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to SUser.swift instead.

import Foundation
import CoreData

public enum SUserAttributes: String {
    case addres = "addres"
    case city = "city"
    case countryCode = "countryCode"
    case currencyCode = "currencyCode"
    case dataCreated = "dataCreated"
    case dateUpdate = "dateUpdate"
    case email = "email"
    case identifier = "identifier"
    case localeCode = "localeCode"
    case name = "name"
    case phone = "phone"
    case zip = "zip"
}

open class _SUser: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "SUser"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    @nonobjc
    open class func fetchRequest() -> NSFetchRequest<SUser> {
        return NSFetchRequest(entityName: self.entityName())
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _SUser.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var addres: String?

    @NSManaged open
    var city: String?

    @NSManaged open
    var countryCode: String?

    @NSManaged open
    var currencyCode: String?

    @NSManaged open
    var dataCreated: Date?

    @NSManaged open
    var dateUpdate: Date?

    @NSManaged open
    var email: String?

    @NSManaged open
    var identifier: Int64 // Optional scalars not supported

    @NSManaged open
    var localeCode: String?

    @NSManaged open
    var name: String?

    @NSManaged open
    var phone: String?

    @NSManaged open
    var zip: String?

    // MARK: - Relationships

}

