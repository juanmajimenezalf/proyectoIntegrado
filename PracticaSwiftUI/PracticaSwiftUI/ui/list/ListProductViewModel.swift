//
//  ListViewModel.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 10/1/23.
//

import Foundation

class ListProductViewModel: ObservableObject {
    @Published var items: [ProductBO]?
    @Published var state: StateListProduct = .idle
    private lazy var productRepository: ProductRepository = ProductWS()
    
}

@MainActor
extension ListProductViewModel {
    
    func loadProducts() async {
        state = .loading
        Task {
            do {
                items = try await productRepository.loadListProduct()
                guard let items else {
                    state = .error("Sin productos")
                    return
                }
                state = .loaded(items)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
