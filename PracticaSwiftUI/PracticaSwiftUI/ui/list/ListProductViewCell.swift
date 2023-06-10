//
//  ListViewCell.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 23/1/23.
//

import SwiftUI

struct ListProductViewCell: View {
    let product: ProductBO
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                if let image = product.imageURL {
                    AppImage(url: image, contentMode: .fill)
                        .frame(width: 140)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 3)
                        }
                }
                VStack(alignment: .leading, spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(product.title)
                            .font(.openSemiBold(size: 16))
                            .foregroundColor(.black)
                        Text(product.type.rawValue)
                            .padding(5)
                            .foregroundColor(.whiteCustom)
                            .font(.regular(size: 14))
                            .background(Color.marine)
                            .clipShape(RoundedRectangle(cornerRadius: 2))
                    }
                    Text(String(format: "%.2f €", product.price))
                        .foregroundColor(.marine)
                        .font(.bold(size: 20))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            Color.gray.opacity(0.4)
                .frame(height: 1)
                .padding(.top, 20)
        }
        .padding(.top, 20)
    }
}

struct ListProductViewCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ListProductViewCell(product: ProductBO.mock)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}
