//
//  NetworkManager.swift
//  Github_search
//
//  Created by Mac User on 14.02.2023.
//

import Foundation

class NetworkManager {

    var currentRequest: URLSessionDataTask?
    
    enum ManagerErrors: Error {
        case invalidResponse
        case invalidStatusCode(Int)
    }

    enum HttpMethod: String {
        case get
        case post

        var method: String { rawValue.uppercased() }
    }

    func request(fromURL url: URL, httpMethod: HttpMethod = .get, completion: @escaping (Result<Data?, Error>) -> Void) {

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method

        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else { return completion(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completion(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }

            completion(.success(data))
        }

        // Start the request
        urlSession.resume()
        
        self.currentRequest = urlSession
    }
}
