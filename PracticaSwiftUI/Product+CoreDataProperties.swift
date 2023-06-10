//
//  Product+CoreDataProperties.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 8/6/23.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var descriptions: String?
    @NSManaged public var id: UUID?
    @NSManaged public var imageURL: String?
    @NSManaged public var price: Double
    @NSManaged public var rating: Int16
    @NSManaged public var title: String?
    @NSManaged public var type_p: String?
    @NSManaged public var prodOrder: NSSet?
    @NSManaged public var prodReview: NSSet?

}

// MARK: Generated accessors for prodOrder
extension Product {

//    @objc(addProdOrderObject:)
//    @NSManaged public func addToProdOrder(_ value: Order)
//
//    @objc(removeProdOrderObject:)
//    @NSManaged public func removeFromProdOrder(_ value: Order)

    @objc(addProdOrder:)
    @NSManaged public func addToProdOrder(_ values: NSSet)

    @objc(removeProdOrder:)
    @NSManaged public func removeFromProdOrder(_ values: NSSet)

}

// MARK: Generated accessors for prodReview
extension Product {

//    @objc(addProdReviewObject:)
//    @NSManaged public func addToProdReview(_ value: Review)
//
//    @objc(removeProdReviewObject:)
//    @NSManaged public func removeFromProdReview(_ value: Review)

    @objc(addProdReview:)
    @NSManaged public func addToProdReview(_ values: NSSet)

    @objc(removeProdReview:)
    @NSManaged public func removeFromProdReview(_ values: NSSet)

}

extension Product : Identifiable {

}
