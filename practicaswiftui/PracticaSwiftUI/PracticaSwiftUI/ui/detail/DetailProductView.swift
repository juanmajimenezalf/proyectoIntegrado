//
//  DetailProductView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 13/1/23.
//

import SwiftUI

struct DetailProductView: View {
    let product: ProductBO
    @EnvironmentObject var shoppingCart: ShoppingCart
    var hideButton: Bool {
        return  shoppingCart.getAmount(product: product) == 0
    }
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBarCustom {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.whiteCustom)
                }
                .frame(width: 44, height: 44)
                
            } centralView: {
                Text("Detalle producto")
                    .font(.bold(size: 20))
                    .foregroundColor(.whiteCustom)
            }
            content
        }
        .frame(maxHeight: .infinity ,alignment: .top)
        .navigationBarHidden(true)
        .background(Color.marine.opacity(0.05))
        .background(Color.whiteCustom)
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    var content: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 20) {
                    AppImage(url: product.imageURL, showBlur: true)
                        .frame(height: 250)
                    Group {
                        Text(product.title)
                            .font(.openSemiBold(size: 21))
                            .foregroundColor(.black)
                        Text(product.type.rawValue)
                            .padding(5)
                            .foregroundColor(.whiteCustom)
                            .font(.regular(size: 16))
                            .background(Color.marine)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                        RatingProduct(rating: product.rating)
                        Text(product.description)
                            .font(.regular(size: 16))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                    Spacer()
                    HStack(spacing: 20) {
                        if !hideButton {
                            Button {
                                shoppingCart.decrementAmount(product: product)
                            } label: {
                                Text("-")
                                    .font(.bold(size: 20))
                                    .padding(.bottom)
                                    .tint(.marine)
                            }
                        }
                        Button {
                            shoppingCart.incrementAmount(product: product)
                        } label: {
                            textButtonPrice
                        }
                        .buttonStyle(StyleCustomButton())
                        .padding(.bottom, 20)
                        if !hideButton {
                            Button {
                                shoppingCart.incrementAmount(product: product)
                            } label: {
                                Text("+")
                                    .font(.bold(size: 20))
                                    .padding(.bottom)
                                    .tint(.marine)
                            }
                        }
                    }
                }
                .frame(minHeight: proxy.size.height)
            }
        }
    }
}

extension DetailProductView {
    @ViewBuilder
    var textButtonPrice: some View {
        if shoppingCart.getAmount(product: product) == 0 {
            Text("Añadir por " + String(format: "%.2f €", product.price))
        } else {
            Text("\(shoppingCart.getAmount(product: product)) x " + String(format: "%.2f € en el carrito", product.price))
        }
    }
    
}

struct DetailProductView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailProductView(product: ProductBO.mock)
                .environmentObject(ShoppingCart())
        }
    }
}
