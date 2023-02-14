//
//  NetworkManager+Search.swift
//  Github_search
//
//  Created by Mac User on 14.02.2023.
//

import Foundation

extension NetworkManager {
    func searchRepository(query: String, completion: @escaping ([Repository]?, String?) -> Void) {
        
        if let r = self.currentRequest {
            r.cancel()
        }
        
        let endpoint = Endpoint.searchRepository(query: query)
        self.request(fromURL: endpoint.url) { (result: Result<Data?, Error>) in
            
            switch result {
            case .success(let data):
                if let d = data {
                    do {
//                        print(String(data: d, encoding: .utf8)!)
                        
                        let model = try JSONDecoder().decode(RepositoryResponce.self , from: d)
                        completion(model.items, nil)
                    } catch {
                        debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                        completion(nil, error.localizedDescription)
                    }
                } else {
                    completion(nil, "Somethink went wrong")
                }
            case .failure(let error):
                debugPrint("We got a failure trying to get the users. The error we got was: \(error.localizedDescription)")
                completion(nil, error.localizedDescription)
            }
        }
            
    }
}


