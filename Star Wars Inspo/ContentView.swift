//
//  ContentView.swift
//  Star Wars Inspo
//
//  Created by DHC on 10/25/22.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var images = NetworkManager()
    @ObservedObject var slideShows = DataManager()
    
    @State private var idleTimerDisabled = false
    @State private var counter = 0
    @State private var showAlert = false
    
    //Feeds to the toggler to disable or enable idleTimerDisabled which allows users to force the phone to stay awake.
    func idleTimer() {
        idleTimerDisabled ? (UIApplication.shared.isIdleTimerDisabled = true) : (UIApplication.shared.isIdleTimerDisabled = false)
    }
    //UI specific Helper methods
    func goForward () {
        if ((counter + 1) != slideShows.slidesModel.count) {
        counter += 1
    }
    }
    func goBackward () {
        if (counter != 0) {
            counter -= 1
        }
    }
    
    var body: some View {
        
        //timer gets the value from "slideTransitionDelay"
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
                    Image(slideShows.slidesModel[counter].author)
                        .resizable()
                        .scaledToFill()
                        .frame(width: gp.size.width * 0.4, height: gp.size.height * 0.5, alignment: .topTrailing)
                        .cornerRadius(90.0)
                        .opacity(0.8)
                        .position(x: gp.size.width * 0.8, y: gp.size.height * 0.25)
                }
                else {
                    //There no free APIs for Star Wars characters but in professional build these will be programmatically pulled from an API.
                    Image(slideShows.slidesModel[counter].author)
                        .resizable()
                        .scaledToFill()
                        .frame(width: gp.size.width * 0.4, height: gp.size.height * 0.4, alignment: .topTrailing)
                        .cornerRadius(90.0)
                        .opacity(0.8)
                        .position(x: gp.size.width * 0.8, y: gp.size.height * 0.2)
                }
                Spacer()
                VStack{
                    Text(slideShows.slidesModel[counter].quote)
                        .font(.custom(
                            "AmericanTypewriter", size: 34)
                            .weight(.heavy))
                        .foregroundColor(Color.white)
                        .frame(
                            
                            maxWidth: (gp.size.width * 0.9),
                            maxHeight: (gp.size.height * 0.95),
                            alignment: .bottomLeading)
                        .position(x: gp.size.width * 0.5, y: gp.size.height * 0.55)
                    Text(slideShows.slidesModel[counter].author)
                        .font(.custom(
                            "AmericanTypewriter", size: 34)
                            .weight(.heavy))
                        .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.431))
                        .frame(
                            maxWidth: (gp.size.width * 0.9),
                            maxHeight: (gp.size.height * 0.95),
                            alignment: .bottomTrailing)
                    HStack {
                        Spacer()
                            Button(action: goForward) {
                                Image(systemName: "chevron.left")
                                    .imageScale(.large)
                            }
                        Spacer()
                        Toggle(isOn: $idleTimerDisabled)
                        {
                            //improve to other?
                            Image(systemName: "lock").font(Font.system(.largeTitle))
                        }
                        .toggleStyle(.button).tint(.blue).confirmationDialog( "",
                                                                              isPresented: $idleTimerDisabled) {
                            Button("Phone Will Now Stay Awake", role: .destructive) {
                                idleTimerDisabled = true
                            }
                        }
                        Spacer()
                        Button(action: goForward){
                            Image(systemName: "chevron.right")
                                .imageScale(.large)
                                
                            }
                        Spacer()
                }.frame(
                    maxWidth: gp.size.width,
                    maxHeight: (gp.size.height * 0.05),
                    alignment: .center)
                .background(Color.gray)
                }.position(x: gp.size.width * 0.5, y: gp.size.height * 0.5)
               
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
