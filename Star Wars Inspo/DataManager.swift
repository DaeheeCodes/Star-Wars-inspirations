//
//  DataManager.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/25/22.
//

import Foundation

class DataManager: ObservableObject {
    
    @Published var slidesModel = [SlidesModel]()
    
    
    
    init() {
        // Plug in whatever database
        loadJSON(loadData("Database")!, [SlidesModel].self)
    }
    
    //Uses units of small functions for scaleability and accessibility.
    // For example we can feed any filename to loadData on any other databases if we were to scale for different themes.
    func loadData(_ filename: String) -> Data? {
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
        else {
            //Allows us to catch specific error statements, better than the standar JSON decoding method
            fatalError("File \"\(filename)\" does not exist in main bundle.")
        }
        
        do {
            return try Data(contentsOf: file)
        } catch {
            fatalError("Failed to load \"\(filename)\" from main bundle:\n\(error)")
        }
    }
    
    
    
    func loadJSON<T: Codable>(_ data: Data,_ model: T.Type){
        do {
            let slides = try JSONDecoder().decode(model.self, from: data)
            self.slidesModel = slides as! [SlidesModel]
        } catch {
            fatalError("Failed to decode \"\(data)\" as \(model.self)):\n\(error)")
        }
    }
    
    func printInfo(_ value: Any) {
        let t = type(of: value)
        print("'\(value)' of type '\(t)'")
    }
    
    
}
