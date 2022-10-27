//
//  ContentView.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/25/22.
//
import SwiftUI

struct ContentView: View {
    //fetch the data
    @ObservedObject var images = NetworkManager()
    @ObservedObject var slideShows = DataManager()
    
    @State private var counter = 0
    


    
    var body: some View {
        
        //timer gets transition time from "slideTransitionDelay"
        let timer = Timer.publish(every: Double(slideShows.slidesModel[counter].slideTransitionDelay), on: .main, in: .common).autoconnect()
        
        //GeometryReader to adjust view sizes based on current screen size and ratio.
        GeometryReader { gp in
            ZStack {
                if (images.imageModels.count > 0) {
                AsyncImage(url: URL(string: images.imageModels[counter].links.download ),
                             content: { image in
                             image
                               .resizable()
                               .aspectRatio(contentMode: .fill)
                           }, placeholder: {
                             Color.gray
                           })
                             .edgesIgnoringSafeArea(.all)
                             .frame(width: gp.size.width, height: gp.size.height, alignment: .center)
                }
                if ( gp.size.width > gp.size.height) {
                    Image("Leia")
                           .resizable()
                           .scaledToFill()
                           .frame(width: gp.size.width * 0.4, height: gp.size.height * 0.5, alignment: .topTrailing)
                           .cornerRadius(90.0)
                           .opacity(0.5)
                           .position(x: gp.size.width * 0.8, y: gp.size.height * 0.25)
                }
                else {
                    Image("Leia")
                           .resizable()
                           .scaledToFill()
                           .frame(width: gp.size.width * 0.4, height: gp.size.height * 0.4, alignment: .topTrailing)
                           .cornerRadius(90.0)
                           .opacity(0.5)
                           .position(x: gp.size.width * 0.8, y: gp.size.height * 0.2)
                }
                Spacer()
                        HStack{
                            Text(slideShows.slidesModel[counter].quote)
                                .font(.largeTitle)
                                .foregroundColor(Color.white)
                                .frame(

                                    maxWidth: (gp.size.width * 0.8),
                                                maxHeight: (gp.size.height * 0.95),
                                                alignment: .bottomLeading)
                            Spacer()
                            Text(slideShows.slidesModel[counter].author)
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.431))
                                .frame(

                                                maxWidth: (gp.size.width * 0.8),
                                                maxHeight: (gp.size.height * 0.95),
                                                alignment: .bottomTrailing)
                        }.position(x: gp.size.width * 0.5, y: gp.size.height * 0.4)
                }
        }.onReceive(timer) {
            time in
            print(counter - 1)
            if (counter + 1 == (slideShows.slidesModel.count)) {
                counter = 0
            }
            else {
                counter += 1
            }
        }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
