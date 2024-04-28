//
//  NerworkManager.swift
//  WheatherApp
//
//  Created by Yerassyl on 12.04.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}

enum HttpMethods: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case delete = "DELETE"
}

class NetworkManager {
    static let shared = NetworkManager()
    let baseURL = "https://api.weatherapi.com"
    
    private init() {}
    
    func fetchDate(from urlString: String, parameters: [String: Any]?, completion: @escaping (Result<Data, NetworkError>) -> Void){
        guard var urlComponents = URLComponents(string: "\(baseURL)/v1/\(urlString)") else {
            completion(.failure(.invalidURL))
            return
        }
        if let parameters = parameters {
            urlComponents.queryItems = parameters.map {
                URLQueryItem(name: $0, value: "\($1)")
            }
        }
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        print(url.absoluteString)
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let error = error {
                completion(.failure(.serverError("Server ERROR: \(error.localizedDescription)")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError("Server ERROR")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
            
        
        
    }
}
