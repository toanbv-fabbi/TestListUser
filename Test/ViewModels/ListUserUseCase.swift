//
//  ListUserUseCase.swift
//  Test
//
//  Created by cmc on 15/12/2022.
//

import UIKit

protocol ListUserUseCase {
    func getListUser(completion: @escaping (Result<[InfoUser], Error>) -> Void)
}
class DefaultListUserUseCase: ListUserUseCase {
    
    init () {
        
    }
    
    func getListUser(completion: @escaping (Result<[InfoUser], Error>) -> Void) {
        guard let gitUrl = URL(string: Constants.baseUrl) else {
            completion(.failure(ApiError.wrongUrl))
            return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(ApiError.dataNil))
                }
                return }
            
            do {
                let decoder = JSONDecoder()
                let infoUsers = try decoder.decode([InfoUser].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(infoUsers))
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
enum ApiError: Error {
    case wrongUrl
    case dataNil
}
