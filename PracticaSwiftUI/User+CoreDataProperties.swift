//
//  User+CoreDataProperties.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 8/6/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var admin: Bool
    @NSManaged public var date: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var last_name: String?
    @NSManaged public var name: String?
    @NSManaged public var number_id: String?
    @NSManaged public var password: String?
    @NSManaged public var type_id: String?
    @NSManaged public var username: String?
    @NSManaged public var userOrder: NSSet?

}

// MARK: Generated accessors for userOrder
extension User {

//    @objc(addUserOrderObject:)
//    @NSManaged public func addToUserOrder(_ value: Order)
//
//    @objc(removeUserOrderObject:)
//    @NSManaged public func removeFromUserOrder(_ value: Order)

    @objc(addUserOrder:)
    @NSManaged public func addToUserOrder(_ values: NSSet)

    @objc(removeUserOrder:)
    @NSManaged public func removeFromUserOrder(_ values: NSSet)

}

extension User : Identifiable {

}
