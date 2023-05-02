//
//  APIService.swift
//  WisdomLeaf
//
//  Created by Atul Gupta on 02/05/23.
//

import Foundation

protocol NetworkService {
    associatedtype ResponseType: Decodable
    
    func fetch(from url: URL, completion: @escaping (Result<ResponseType, Error>) -> Void)
}

class APIService<T: Decodable>: NetworkService {
    typealias ResponseType = T
    
    func fetch(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                completion(.failure(NSError(domain: "Invalid response status code", code: statusCode, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase //MARK: We can also this instead of making CodingKeys enum inside the model class
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
                
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
}
