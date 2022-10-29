//
//  NetworkManager.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/26/22.
//

import Foundation

import SwiftUI

//@MainActor for concurrency, updates to main thread automatically.

@MainActor class NetworkManager: ObservableObject{
    //Fetch and load images URL
    @Published var imageModels = [imgModel]()
    //Publish Image Data
    
    let apiKey = Bundle.main.object(forInfoDictionaryKey: "UNSPLASH_API") as! String
    
    init() {
        fetchImg("9860299")
    }
    
    //units of small functions for scaleability and accessibility.
    // for example we can expand loadData to any other databases if we were to scale for different themes.
    func fetchImg(_ query: String) {
        guard let url = URL(string: "https://api.unsplash.com/collections/\(query)/photos?client_id=\(apiKey)" )
        else {
            //allows us to catch specific error statements, better than the standar JSON decoding method
            fatalError("Invalid URL at \"\(query)\" .")
        }
        print(url)
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error fetching images: \(error.localizedDescription)")
            }
            
            guard let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let response = try decoder.decode([imgModel].self, from: jsonData)
                print(response)
                self.imageModels = response
            } catch {
                //Expected to decode Array<Any> but found a dictionary instead.
                print("Error decoding data. \(error)")
            }
        }
        dataTask.resume()
 }
}
