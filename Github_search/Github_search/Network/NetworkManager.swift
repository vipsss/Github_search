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

        let completionOnMain: (Result<Data?, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.method

        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completionOnMain(.failure(error))
                return
            }

            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }

            completionOnMain(.success(data))
            
            // Now that all our prerequisites are fullfilled, we can take our data and try to translate it to our generic type of T.
//            guard let data = data else { return }
//            do {
//                let users = try JSONDecoder().decode(T.self, from: data)
//                completionOnMain(.success(users))
//            } catch {
//                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
//                completionOnMain(.failure(error))
//            }
        }

        // Start the request
        urlSession.resume()
        
        self.currentRequest = urlSession
    }
}
