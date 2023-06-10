//
//  TabView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 18/1/23.
//

import SwiftUI

enum TabSelection {
    case listado
    case carrito
}

struct CustomTabView: View {
    @StateObject var appEnvironment = AppEnvironment()
    @State var selectionTab: TabSelection = .listado
    
    var body: some View {
        TabView(selection: $selectionTab) {
            NavigationView {
                ListProductView()
            }
            .tabItem {
                Label("Listado", systemImage: "list.bullet")
            }
            .tag(TabSelection.listado)
            .toolbar(.visible, for: .tabBar)
            .toolbarBackground(Color.whiteCustom, for: .tabBar)
            ShoppingCartView()
                .tabItem {
                    Label("Carrito", systemImage: "cart")
                }
                .tag(TabSelection.carrito)
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Color.whiteCustom, for: .tabBar)
        }
        .navigationBarHidden(true)
        .onChange(of: appEnvironment.selectionTab) { newValue in
            selectionTab = newValue
        }
        .onChange(of: selectionTab) { newValue in
            appEnvironment.selectionTab = newValue
        }
        .accentColor(.marine)
        .environmentObject(appEnvironment)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomTabView()
        }
        .environmentObject(ShoppingCart())
    }
}
