//
//  ProductGridView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 23/1/23.
//

import SwiftUI

struct ListProductGridView: View {
    let product: ProductBO
    
    var body: some View {
        VStack(spacing: 10) {
            AppImage(url: product.imageURL, contentMode: .fill)
                .frame(height: 147)
                .clipShape(Rectangle())
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.openSemiBold(size: 14))
                    .foregroundColor(.black)
                    .lineLimit(1)
                Text(String(format: "%.2f €", product.price))
                    .font(.openSemiBold(size: 16))
                    .foregroundColor(Color.marine)
                    .padding(.bottom, 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.whiteCustom)
        .padding(.top, 30)
    }
}

struct ListProductGridView_Previews: PreviewProvider {
    private static let colums = [
        GridItem(.adaptive(minimum: 140, maximum: 180), spacing: 17)
    ]
    
    static var previews: some View {
        ScrollView {
            LazyVGrid(columns: colums, spacing: 10) {
                ListProductGridView(product: ProductBO.mock)
                ListProductGridView(product: ProductBO.mock)
                ListProductGridView(product: ProductBO.mock)
                ListProductGridView(product: ProductBO.mock)
            }
            .listStyle(.plain)
            .colorScheme(.light)
            .padding(.top, 30)
            .padding(.bottom, 30)
            .padding(.horizontal, 22)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.marine)
    }
}
