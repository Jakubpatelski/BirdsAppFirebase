//
//  ApiCall.swift
//  LogIn_Birds
//
//  Created by Jakub Patelski on 13/03/2023.
//

import Foundation

struct Bird: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: URL
    let wikipediaUrl: String
}

class BirdData: ObservableObject {
    @Published var birds = [Bird]()
    
    init() {
        // Make the API call
        guard let url = URL(string: "https://a-pi-birds-node-js.vercel.app/") else {
            return
            
        }
        URLSession.shared.dataTask(with: url) {
            data, _, error in
            
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Decode the JSON data
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode([Bird].self, from: data)
                
                // Store the data
                DispatchQueue.main.async {
                    self.birds = result
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
