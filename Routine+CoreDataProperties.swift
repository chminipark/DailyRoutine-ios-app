//
//  Routine+CoreDataProperties.swift
//  DailyRoutine
//
//  Created by minii on 2021/05/14.
//
//

import Foundation
import CoreData


extension Routine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Routine> {
        return NSFetchRequest<Routine>(entityName: "Routine")
    }

    @NSManaged public var name: String
    @NSManaged public var totalcount: Int16
    @NSManaged public var image: Data
    @NSManaged public var color: Data
    @NSManaged public var date: Date
    @NSManaged public var datelist: [String]?
    
}

extension Routine : Identifiable {

}
