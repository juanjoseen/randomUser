//
//  Api.swift
//  RandomUser
//
//  Created by Juan Jose Elias Navarro on 09/06/22.
//

import Foundation

class Api {
    static let shared: Api = Api()
    
    private init() {}
    
    func getRandomUser(completion: @escaping (ApiError?, User?) -> Void) {
        guard let url: URL = URL(string: "https://randomuser.me/api") else {
            completion(.invalidURL, nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
                completion(.conection, nil)
            } else {
                if let data = data {
                    do {
                        let result: Result = try JSONDecoder().decode(Result.self, from: data)
                        completion(nil, result.results.first)
                    } catch {
                        print(error)
                        completion(.decodig, nil)
                    }
                } else {
                    completion(.noData, nil)
                }
            }
        }.resume()
    }
}

enum ApiError: Error {
    case invalidURL
    case conection
    case noData
    case decodig
}
