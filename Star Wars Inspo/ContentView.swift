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
    @State private var showPopup = false
    // Show only once per active session.
    @State private var notShownPopup = true
    @State private var counter = 0
    @State private var showAlert = false
    @State var showMenu: Bool = true
    @Environment(\.scenePhase) private var scenePhase


    //Feeds to the toggler to disable or enable idleTimerDisabled which allows users to force the phone to stay awake.
    func idleTimer() {
        idleTimerDisabled ? (UIApplication.shared.isIdleTimerDisabled = true) : (UIApplication.shared.isIdleTimerDisabled = false)
    }
    
    //determine if iPad or iPhone
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }

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
    
        //Timer gets the value from "slideTransitionDelay"
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
                    if (idiom == .pad) {
                    Image(current.author)
                        .resizable()
                        .frame(width: gp.size.width * 0.4, height: gp.size.height * 0.4, alignment: .topTrailing)
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(15.0)
                        .position(x: gp.size.width * 0.25, y: gp.size.height * 0.25)
                        .opacity(0.9)
                }
                    else {
                        Image(current.author)
                            .resizable()
                            .frame(width: gp.size.width * 0.3, height: gp.size.height * 0.4, alignment: .topTrailing)
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(15.0)
                            .position(x: gp.size.width * 0.2, y: gp.size.height * 0.25)
                            .opacity(0.9)
                    }
                }
                else {
                    //There no free APIs for Star Wars characters but in commercial build these will be programmatically pulled from an API.
                    if (idiom == .pad) {
                    Image(current.author)
                        .resizable()
                        .frame(width: gp.size.width * 0.5, height: gp.size.height * 0.35, alignment: .topTrailing)
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(15.0)
                        .position(x: gp.size.width * 0.3, y: gp.size.height * 0.2)
                        .opacity(0.9)
                }
                    else {
                        Image(current.author)
                            .resizable()
                            .frame(width: gp.size.width * 0.5, height: gp.size.height * 0.3, alignment: .topTrailing)
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(15.0)
                            .position(x: gp.size.width * 0.25, y: gp.size.height * 0.2)
                            .opacity(0.9)
                    }
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
                    //Menu can be hidden if the above view is clicked
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
                            if (idleTimerDisabled && notShownPopup) {
                                showPopup = true
                            }
                        }
                        .confirmationDialog("", isPresented: $showPopup) {
                                Button("Screen will now Stay On", role: .destructive, action: {
                                    notShownPopup = false })
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
            //Release Network Cache when it goes to background.
        }.onChange(of: scenePhase) { phase in
            if phase == .background {
                URLCache.shared.removeAllCachedResponses()
                URLCache.shared.diskCapacity = 0
                URLCache.shared.memoryCapacity = 0
            }
            //Show warning again if the user session was previously ended.
            
            if phase == .active {
                notShownPopup = true
            }
            }
        
    }
    
}

extension Image {
    @warn_unqualified_access
    func square() -> some View {
        Rectangle()
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                self
                    .resizable()
                    .scaledToFill()
            )
            .clipShape(Rectangle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
