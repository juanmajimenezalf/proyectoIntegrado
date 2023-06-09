//
//  ShoppingCartCellView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 23/1/23.
//

import SwiftUI

struct ShoppingCartCellView: View {
    let basket: ShoppingCart.ShoppingBasket
    @EnvironmentObject var shoppingCart: ShoppingCart
    @State var showAlertDeleteProduct: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 20) {
                AppImage(url: basket.product.imageURL, contentMode: .fill)
                    .frame(width: 107, height: 107)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                VStack(alignment: .leading, spacing: 20) {
                    Text(basket.product.title)
                        .font(.openSemiBold(size: 14))
                        .foregroundColor(.black)
                    Text(String(format: "%.2f €", basket.product.price))
                        .font(.bold(size: 20))
                        .foregroundColor(.marine)
                }
                Spacer()
                HStack {
                    Button("-") { }
                    .foregroundColor(.marine)
                    .onTapGesture {
                        if shoppingCart.getAmount(product: basket.product) == 1 {
                            showAlertDeleteProduct = true
                        } else {
                            shoppingCart.decrementAmount(product: basket.product)
                        }
                    }
                    Text("\(basket.amount)")
                        .font(.bold(size: 16))
                        .foregroundColor(.whiteCustom)
                        .frame(height: 34)
                        .frame(minWidth: 34)
                        .background(Color.marine)
                        .clipShape(Capsule())
                    Button("+") { }
                    .foregroundColor(.marine)
                    .onTapGesture {
                        shoppingCart.incrementAmount(product: basket.product)
                    }
                }
            }
            Color.gray.opacity(0.4)
                .frame(height: 1)
                .padding(.horizontal)
                .padding(.vertical, 27)
        }
        .background(alert)
    }
    
    @ViewBuilder
    var alert: some View {
        EmptyView()
            .alert("Eliminar producto", isPresented: $showAlertDeleteProduct) {
                Button("Ok", role: .destructive) {
                    withAnimation(.easeInOut(duration: 4)) {
                        shoppingCart.decrementAmount(product: basket.product)
                    }
                }
                Button("Cancelar", role: .cancel) {
                    
                }
            } message: {
                Text("¿Seguro que quiere eliminar el producto del carrito?")
            }

    }
}


struct ShoppingCartCellView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartCellView(basket: ShoppingCart.ShoppingBasket(amount: 1, product: ProductBO.mock))
    }
}
