//
//  NetworkManager.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/26/22.
//

import Foundation

import SwiftUI

class NetworkManager: ObservableObject{
    
@Published var imageModels = [imgModel]()

    init() {
        //I queried a specific unsplash album for quality control but it can be extended and modified to any queries. all JSON
        fetchImg("9860299")
    }
    
//units of small functions for scaleability and accessibility.
// for example we can expand loadData to any other databases if we were to scale for different themes.
 func fetchImg(_ query: String){
     guard let url = URL(string: "https://api.unsplash.com/collections/\(query)/photos?client_id=1D1wmDROSEx9jh7G7H6dY7bp_ijAiAc-r8bWSWSliLo" )
        else {
        //allows us to catch specific error statements, better than the standar JSON decoding method
            fatalError("Invalid URL at \"\(query)\" .")
    }
     print(url)
     let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
       if let error = error {
         print("Error fetching recipes: \(error.localizedDescription)")
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
    /*
     URLSession.shared.dataTask(with: request) { data, response, error in
                 if let data = data {
                     if let response = try? JSONDecoder().decode([imgModel].self, from: data) {
                         DispatchQueue.main.async {
                             self.imageModels = response
                         }
                         return
                     }
                 }
            
             }.resume()
     */
         }

}
