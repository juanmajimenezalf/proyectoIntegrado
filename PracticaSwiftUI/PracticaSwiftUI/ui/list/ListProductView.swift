//
//  ListView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 10/1/23.
//

import SwiftUI

struct ListProductView: View {
    @StateObject private var listProductViewModel = ListProductViewModel()
    @State var typeView: TypeView = .list
    let colums = [
        GridItem(.adaptive(minimum: 160, maximum: 180), spacing: 17)
    ]
    
    var body: some View {
        content
            .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private var content: some View {
        VStack(spacing: 0) {
            NavigationBarCustom(centralView: {
                Text("Listado")
                    .font(.bold(size: 20))
                    .foregroundColor(.whiteCustom)
            }, rightView: {
                HStack(spacing: 0) {
                    Button {
                        typeView.toggle()
                    } label: {
                        Image(systemName: "list.bullet")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(changeBackgroundButtonList())
                            .foregroundColor(changeForegroundButtonList())
                    }
                    Button {
                        typeView.toggle()
                    } label: {
                        Image(systemName: "circle.grid.2x2")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(changeBackgroundButtonGrid())
                            .foregroundColor(changeForegroundButtonGrid())
                    }
                }
                .padding(.trailing, 60)
            })
            GeometryReader { proxy in
                switch listProductViewModel.state {
                case .idle:
                    Color.clear
                        .onAppear {
                            Task {
                                await listProductViewModel.loadProducts()
                            }
                        }
                case .loading:
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                        .scaleEffect(1.5)
                        .frame(maxWidth: .infinity, minHeight: proxy.size.height)
                case .loaded(let listProduct):
                    switch typeView {
                    case .list:
                        List {
                            ForEach(listProduct) { product in
                                NavigationLink {
                                    DetailProductView(product: product)
                                } label: {
                                    ListProductViewCell(product: product)
                                }
                                .listRowSeparator(.hidden)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(.plain)
                        .colorScheme(.light)
                        .background(Color.marine.opacity(0.05))
                        .scrollContentBackground(.hidden)
                    case .grid:
                        ScrollView {
                            LazyVGrid(columns: colums, spacing: 30) {
                                ForEach(listProduct) { product in
                                    NavigationLink {
                                        DetailProductView(product: product)
                                    } label: {
                                        ListProductGridView(product: product)
                                    }
                                    .clipShape(RoundedRectangle(cornerRadius: 2.2))
                                }
                            }
                            .listStyle(.plain)
                            .padding(.horizontal, 25)
                            .padding(.bottom, 30)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                case .error(let error):
                    VStack(spacing: 10) {
                        Image(systemName: "wifi.exclamationmark")
                            .resizable()
                            .frame(width: 41, height: 36)
                            .foregroundColor(Color.marine)
                        Text("\(error)")
                        Button("Reintentar") {
                            Task {
                                await listProductViewModel.loadProducts()
                            }
                        }
                        .buttonStyle(StyleCustomButton())
                        .padding(.top, 30)
                    }
                    .frame(maxWidth: .infinity ,minHeight: proxy.size.height)
                }
            }
        }
        .background(Color.marine.opacity(0.05))
        .background(Color.whiteCustom)
        .preferredColorScheme(.dark)
    }
}

extension ListProductView {
    enum TypeView {
        case list
        case grid
        
        mutating func toggle() {
            switch self {
            case .list:
                self = .grid
            case .grid:
                self = .list
            }
        }
    }
    
    func changeBackgroundButtonList() -> Color {
        typeView == .list ? Color.whiteCustom : Color.marine
    }
    
    func changeBackgroundButtonGrid() -> Color {
        typeView == .grid ? Color.whiteCustom : Color.marine
    }
    
    func changeForegroundButtonList() -> Color {
        typeView == .list ? Color.marine  : Color.whiteCustom
    }
    
    func changeForegroundButtonGrid() -> Color {
        typeView == .grid ? Color.marine  : Color.whiteCustom
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListProductView()
        }
        .environmentObject(ShoppingCart())
    }
}
