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
    @State var showMenu: Bool = true

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
    
    // async load DispatchGroup
    
    var body: some View {
        
        
        
        //timer gets the value from "slideTransitionDelay"
        let timer = Timer.publish(every: Double(slideShows.slidesModel[counter].slideTransitionDelay), on: .main, in: .common).autoconnect()
        let current = slideShows.slidesModel[counter]
        
        //GeometryReader to adjust view sizes based on current screen size and ratio.
        GeometryReader { gp in
            let landscape = (gp.size.width > gp.size.height)
            ZStack {
                        if (images.imageModels.count > 0) {
                    AsyncImage(url: URL(string: images.imageModels[counter].links.download ),
                               content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }, placeholder: {
                        Color.gray
                        ProgressView()
                                        .progressViewStyle(.circular)
                    })
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: gp.size.width, height: gp.size.height, alignment: .center)
                }
                if (landscape) {
                    Image(current.author)
                        .resizable()
                        //.scaledToFill()
                        .frame(width: gp.size.width * 0.4, height: gp.size.height * 0.4, alignment: .topTrailing)
                        .cornerRadius(15.0)
                        .position(x: gp.size.width * 0.2, y: gp.size.height * 0.25)
                }
                else {
                    //There no free APIs for Star Wars characters but in commercial build these will be programmatically pulled from an API.
                    Image(current.author)
                        .resizable()
                        .frame(width: gp.size.width * 0.5, height: gp.size.height * 0.35, alignment: .topTrailing)
                        .cornerRadius(15.0)
                        .position(x: gp.size.width * 0.23, y: gp.size.height * 0.2)
                }
                Spacer()
                VStack{
                    Text(current.quote)
                        .font(
                                .title2
                                .weight(.bold)
                            )
                        .foregroundColor(Color.white)
                        .frame(
                            
                            maxWidth: (gp.size.width * 0.9),
                            maxHeight: (gp.size.height * 0.95),
                            alignment: .bottomLeading)
                        .position(x: gp.size.width * 0.5, y: gp.size.height * 0.55)
                    Text(current.author)
                        .font(
                                .title2
                                .weight(.bold)
                            )
                        .foregroundColor(Color(red: 1.0, green: 0.0, blue: 0.431))
                        .frame(
                            maxWidth: (gp.size.width * 0.9),
                            maxHeight: (gp.size.height * 0.95),
                            alignment: .bottomTrailing)
                    if (showMenu) {
                    HStack {
                        Spacer()
                        Button(action: goBackward) {
                            Image(systemName: "arrowtriangle.left.fill")
                                .imageScale(.large)
                        }
                        Spacer()
                        Button(idleTimerDisabled ? "Frame Mode On" : "Frame Mode Off")
                        {
                            idleTimerDisabled.toggle()
                        }
                        Spacer()
                        Button(action: goForward){
                            Image(systemName: "arrowtriangle.right.fill")
                                .imageScale(.large)
                            
                        }
                        Spacer()
                    }.frame(
                        maxWidth: gp.size.width,
                        maxHeight: 35,
                        alignment: .center)
                    .background(Color.white)
                    }
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
        }.onTapGesture {
            showMenu.toggle()
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
