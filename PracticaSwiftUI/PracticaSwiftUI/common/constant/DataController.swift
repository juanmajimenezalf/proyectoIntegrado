//
//  DataController.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 7/6/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer (name: "Model")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func createUser(name: String, last_name: String, type_id: String, number_id: String, date: String, username: String, password: String, email: String, admin: Bool, context: NSManagedObjectContext) {
        let newUser = User(context: context)
        newUser.id = UUID()
        newUser.name = name
        newUser.last_name = last_name
        newUser.type_id = type_id
        newUser.number_id = number_id
        newUser.date = date
        newUser.email = email
        newUser.username = username
        newUser.password = password
        newUser.admin = false
        
        save(context: context)
    }
    
    func login(username: String, password: String, context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
            
            do {
                let users = try context.fetch(fetchRequest)
                return !users.isEmpty
            } catch {
                fatalError("Error al autenticar al usuario: \(error)")
            }
    }
    
    func addProduct(title: String, imageURL: String, category: String, rating: Int16, description: String, price: Double, context: NSManagedObjectContext) {
        let newProduct = Product(context: context)
        newProduct.id = UUID()
        newProduct.title = title
        newProduct.imageURL = imageURL
        newProduct.type_p = category
        newProduct.rating = rating
        newProduct.price = price
        newProduct.descriptions = description
        
        save(context: context)
    }
    
    func editProduct(product: Product, title: String, imageURL: String, category: String, rating: Int16, description: String, price: Double, context: NSManagedObjectContext) {
        product.title = title
        product.type_p = category
        product.rating = rating
        product.price = price
        product.imageURL = imageURL
        product.descriptions = description
        
        save(context: context)
    }
    
}
