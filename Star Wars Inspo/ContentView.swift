//
//  ContentView.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var slideShows = DataManager()
    
    var body: some View {
        List(slideShows.slidesModel){ slide in
            
            VStack(alignment: .leading) {
                
                Text(slide.author)
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.gray)
                    
                HStack{
                    Text(slide.quote)
                        .font(.title3)
                        .foregroundColor(Color.red)
                        
                    Spacer()
                    Text(slide.author)
                        .font(.title3)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
