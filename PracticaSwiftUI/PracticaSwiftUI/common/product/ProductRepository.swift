//
//  ProductRepository.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 10/1/23.
//

import Foundation

enum RepositoryError: Error {
    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case noData
}

protocol ProductRepository {
    func loadListProduct(completion: @escaping (Result<[ProductBO], Error>) -> Void)
    func loadListProduct() async throws -> [ProductBO]
//    func loadListProductAsync() async throws -> [ProductBO]
}


class ProductWS: ProductRepository {
    
    @available(*, renamed: "loadListProduct()")
    func loadListProduct(completion: @escaping (Result<[ProductBO], Error>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/juanmajimenezalf/JSON-Sample/main/Products/products.json")
        else {
            completion(.failure(RepositoryError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let response = response as? HTTPURLResponse {
                if 200 ..< 300 ~= response.statusCode {
                    if let data = data {
                        do {
                            let result = try JSONDecoder().decode([ProductDTO].self, from: data)
                            let resultBO = result.compactMap { ProductBO(dto: $0) }
                            completion(.success(resultBO))
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(RepositoryError.noData))
                    }
                } else {
                    completion(.failure(RepositoryError.statusCode(response.statusCode)))
                }
            } else {
                completion(.failure(RepositoryError.invalidResponse))
            }
        }.resume()
    }
    
    func loadListProduct() async throws -> [ProductBO] {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return try await withCheckedThrowingContinuation { continuation in
            loadListProduct() { result in
                continuation.resume(with: result)
            }
        }
    }
    
//    func loadListProductAsync() async throws -> [ProductBO] {
//        guard let url = URL(string: "https://raw.githubusercontent.com/SDOSLabs/JSON-Sample/master/Products/products.json") else {
//            throw RepositoryError.invalidURL
//        }
//
//        let (data, response) = try await URLSession.shared.data(from: url)
//        if let response = response as? HTTPURLResponse {
//            if 200 ..< 300 ~= response.statusCode {
//                let result = try JSONDecoder().decode([ProductDTO].self, from: data)
//                let resultBO = result.compactMap{ ProductBO(dto: $0) }
//                return resultBO
//            } else {
//                throw RepositoryError.statusCode(response.statusCode)
//            }
//        } else {
//            throw RepositoryError.invalidResponse
//        }
//    }
    
}
