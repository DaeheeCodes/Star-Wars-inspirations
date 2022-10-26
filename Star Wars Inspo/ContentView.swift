//
//  ContentView.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/25/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var slideShows = DataManager()
    @ObservedObject var images = NetworkManager()
    
    var body: some View {
        //GeometryReader to read dynamic screen ratio/size changes.
        GeometryReader { gp in
            ZStack {
                //let _ = print(images.imageModels.first?.links)

                AsyncImage(url: URL(string: images.imageModels.last!.links.download),
                             content: { image in
                             image
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                           }, placeholder: {
                             Color.gray
                           })
                             .edgesIgnoringSafeArea(.all)
                             .frame(width: gp.size.width, height: gp.size.height, alignment: .center)

                    Image("Leia")
                           .resizable()
                           .scaledToFill()
                           .edgesIgnoringSafeArea(.all)
                           .frame(width: gp.size.width * 0.4, height: gp.size.height * 0.4, alignment: .center)
                           .cornerRadius(40.0)
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
                }.opacity(0.8)
                       }
        }
  }
}

/*
public extension View {
    func fullBackground(imageName: String) -> some View {
       return background(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
       )
    }
}
*/
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
