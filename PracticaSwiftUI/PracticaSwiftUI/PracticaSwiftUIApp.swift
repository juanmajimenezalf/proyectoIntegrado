//
//  PracticaSwiftUIApp.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 23/12/22.
//

import SwiftUI

@main
struct PracticaSwiftUIApp: App {
    @StateObject var shoppingCart = ShoppingCart()
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            
            NavigationView {
                LoginView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(shoppingCart)
            .navigationViewStyle(.stack)
        }
    }
}
