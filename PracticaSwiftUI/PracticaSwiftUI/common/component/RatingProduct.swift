//
//  RatingProduct.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 13/1/23.
//

import SwiftUI

struct RatingProduct: View {
    var rating: Int

    var maximumRating = 5

    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.orangeYellow
    var onColor = Color.orangeYellow
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}

struct RatingProduct_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RatingProduct(rating: 3, onColor: .red)
            RatingProduct(rating: 3, onImage: Image(systemName: "circle.fill"))
            RatingProduct(rating: 2)
            RatingProduct(rating: 10, maximumRating: 15)
        }
    }
}
