//
//  Star_Wars_InspoTest.swift
//  Star Wars InspoTest
//
//  Created by DHC on 10/30/22.
//

import XCTest

class Star_Wars_InspoTest: XCTestCase {

    struct SlidesModel: Codable, Identifiable {
        
        //JSON naming convention was straight forward but we can always switch it with Enums
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

    
    func testSuccessParser() {
      let json = """
      [
        {

          "quote": "Do. Or do not. There is no try.",

          "author": "Daehee",

          "slideTransitionDelay": 9999999

        }
      ]
      """.data(using: .utf8)!
      
      let slide = try! JSONDecoder().decode([SlidesModel].self, from: json)
      
        XCTAssertNotNil(slide)
        XCTAssertEqual(slide.first?.author, "Daehee")
        XCTAssertEqual(slide.first?.slideTransitionDelay, 9999999)
     }
}
