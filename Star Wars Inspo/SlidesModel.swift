//
//  SlidesModel.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/25/22.
//

import Foundation
import SwiftUI

struct SlidesModel: Codable, Identifiable {
    
    enum CodingKeys: CodingKey {
           case quote
           case author
           case slideTransitionDelay
       }
    
        var id = UUID()
        var quote: String
        var author: String
        var slideTransitionDelay: Int
    
}
