//
//  Array+NSManagedObjectContext.swift
//  SimplePhotoAlbum
//
//  Created by user on 17.01.2022.
//

import CoreData

public extension Array where Element: NSManagedObject {
    
    func moveToContext(_ aContext: NSManagedObjectContext) -> [Element] {
        
        var result: [Element] = []
        
        for obj: Element in self {
            
            if let newObj: Element = obj.inContext(aContext) {
                result.append(newObj)
            }
        }
        
        return result
    }
}

public extension NSManagedObject {
    
    func inContext(_ aContext: NSManagedObjectContext) -> Self? {
        return inContext(aContext, type: type(of: self))
    }
    
    private func inContext<T>(_ aContext: NSManagedObjectContext, type: T.Type) -> T? {
        var result: T?
        
        do {
            try managedObjectContext?.obtainPermanentIDs(for: [self])
            aContext.performAndWait {
                result = aContext.object(with: objectID) as? T
            }
        } catch {
            
        }
        
        return result
    }
}
