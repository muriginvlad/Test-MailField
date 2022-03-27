//
//  NetworkService.swift
//  MailField
//
//  Created by Vladislav on 27.03.2022.
//

import Foundation

class NetworkService {
    private let decoder = JSONDecoder()
    
    func getKickboxData(email: String, completion: @escaping (KickboxResponseModel?, Error?) -> Void) {
        let apiKeyTest = "test_644c7805721ef3bcdb391e59aa8315350c33440b7246a7305429ab428ed3e320"
        let apiKeyLive = "live_484f6bb5f64bff52a77ce4e2d5780e74d0471a6b224a9d6bb623e7dbdc8daac5"
        
        let url = "https://api.kickbox.com/v2/verify?email=\(email)&apikey=\(apiKeyLive)"
        if let URL = URL(string: url) {
                self.performRequest(URL: URL, completion: completion)
        }
    }
    
    private func performRequest<T: Decodable>(URL: URL, completion: @escaping (T?, Error?) -> Void) {
        let sharedSession = URLSession.shared
        let dataTask = sharedSession.dataTask(with: URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print("Error to load: \(String(describing: error?.localizedDescription))")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            if let dataResponse = data {
                do {
                    let newdata = try self.decoder.decode(T.self, from: dataResponse)
                    DispatchQueue.main.async {
                        completion(newdata, nil)
                    }
                    return
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        })
        dataTask.resume()
    }
}
