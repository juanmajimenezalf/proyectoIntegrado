//
//  NavigationBarCustom.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 13/1/23.
//

import SwiftUI

struct NavigationBarCustom<LeftView: View, CentralView:View, RigthView: View> : View {
    private let leftView: () -> LeftView
    private let centralView: () -> CentralView
    private let rightView: () -> RigthView
    
    init(@ViewBuilder leftView: @escaping () -> LeftView = { EmptyView() }, @ViewBuilder centralView: @escaping () -> CentralView, @ViewBuilder rightView: @escaping () -> RigthView = { EmptyView() }) {
        self.leftView = leftView
        self.centralView = centralView
        self.rightView = rightView
    }
    
    var body: some View {
            HStack {
                Color.clear
                    .overlay(alignment: .center) {
                        leftView()
                    }
                    .frame(width: 60)
                Color.clear
                    .overlay(alignment: .center) {
                        centralView()
                    }
                Color.clear
                    .overlay(alignment: .center) {
                        rightView()
                    }
                    .frame(width: 60)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.marine)
    }
}

struct NavigationBarCustom_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NavigationBarCustom (centralView: {
                Text("Registro")
                    .font(.title)
            }, rightView: {
                    Button {
                        
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 26, height: 24)
                            .tint(.whiteCustom)
                    }
            })
            Text("Hola mundo")
            Text("Hola mundo")
            Text("Hola mundo")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea(.container, edges: .bottom)
    }
}
