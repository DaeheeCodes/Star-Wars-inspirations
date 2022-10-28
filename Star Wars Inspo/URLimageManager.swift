//
//  URLimageModel.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/28/22.
//

//Cache image to support .task, await calls on the main view
//Image caching system is heavily referenced from the following guide https://schwiftyui.com/swiftui/downloading-and-caching-images-in-swiftui/

import Foundation
import SwiftUI

@MainActor class URLimageManager: ObservableObject{

@Published var image: UIImage?
var url: String?
var imgCache = ImgCache.getImgCache()

init(url: String?) {
    self.url = url
    loadImage()
}




class ImgCache {
    var cache = NSCache<NSString, UIImage>()
    private static var imgCache = ImgCache()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
            
    static func getImgCache() -> ImgCache {
        return imgCache
    }
}

func loadImage() {
        if loadImageFromCache() {
            print("Cache hit")
            return
        }
        
        print("Cache miss, loading from url")
        loadImageFromUrl()
    }

func loadImageFromCache() -> Bool {
    guard let urlString = url else {
        return false
    }
    
    guard let cacheImage = imgCache.get(forKey: urlString) else {
        return false
    }
    
    image = cacheImage
    return true
}

func loadImageFromUrl() {
    guard let urlString = url else {
        return
    }
    
    let url = URL(string: urlString)!
    let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
        if let error = error {
            print("Error: \(error.localizedDescription)")
        }
        guard let data = data else {
            print("No data found")
            return
        }
        guard let loadedImage = UIImage(data: data) else {
            return
        }
        self.imgCache.set(forKey: self.url!, image: loadedImage)
        self.image = loadedImage
    }
    task.resume()
}
}

