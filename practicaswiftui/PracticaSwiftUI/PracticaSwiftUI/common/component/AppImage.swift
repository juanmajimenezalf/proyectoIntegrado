//
//  AppImage.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 10/1/23.
//

import Foundation
import SwiftUI

struct AppImage: View {
    let url: URL
    let showBlur: Bool
    let contentMode: ContentMode
    @State var image: UIImage? = nil
    
    init(url: URL, showBlur: Bool = false, contentMode: ContentMode = .fit) {
        self.url = url
        self.showBlur = showBlur
        self.contentMode = contentMode
    }
    
    var body: some View {
        Color.clear.overlay {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else {
                Color.gray
                    .onAppear {
                        Task {
                            let (data, _) = try await URLSession.shared.data(from: url)
                            await MainActor.run {
                                image = UIImage(data: data)
                            }
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .background(blurView)
        .clipped()
       
    }
    
    @ViewBuilder
    var blurView: some View {
        if let image = image, showBlur {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity)
                .blur(radius: 6)
                .opacity(0.6)
        } else {
            EmptyView()
        }
    }
}

struct AppImage_Previews: PreviewProvider {
    static var previews: some View {
        AppImage(url: URL(string: "https://static.wikia.nocookie.net/dbz-dokkanbattle/images/2/24/Card_1021700_artwork.png/revision/latest/scale-to-width-down/250?cb=20220813175154")!, showBlur: true)
            .frame(height: 300)
            .frame(maxWidth: .infinity)
    }
}
