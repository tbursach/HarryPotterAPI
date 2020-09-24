//
//  CharacterController.swift
//  HarryPotterAPI
//
//  Created by Trevor Bursach on 9/23/20.
//

import UIKit

struct StringConstants {
 
    fileprivate static let baseURL = "https://hp-api.herokuapp.com"
    fileprivate static let apiEndpoint = "api"
    fileprivate static let charactersEndpoint = "characters"
    
}

class CharacterController {

    static func fetchCharacter(completion: @escaping (Result <[Character], CharacterError>) -> Void) {
        
        guard let baseURL = URL(string: StringConstants.baseURL) else { return completion(.failure(.invalidURL)) }
        let apiComponentURL = baseURL.appendingPathComponent(StringConstants.apiEndpoint)
        let finalURL = apiComponentURL.appendingPathComponent(StringConstants.charactersEndpoint)
       print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevelDictionary = try JSONDecoder().decode([Character].self, from: data)
                let characters = topLevelDictionary
                return completion(.success(characters))
                
            } catch {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
        
    }
    
    static func fetchImageFrom(characterURL: String, completion: @escaping (Result<UIImage, CharacterError>) -> Void) {
        guard let imageURL = URL(string: characterURL) else { return completion(.failure(.invalidURL)) }
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(image))
        }.resume()
    }
    
} // END OF CLASS
