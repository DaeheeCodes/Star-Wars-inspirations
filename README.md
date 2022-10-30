# Inspirations - Star Wars Edition
#### By Daehee Hwang

<img width="1281" alt="Screen Shot 2022-10-30 at 1 22 50 AM" src="https://user-images.githubusercontent.com/102007615/198869372-19aeb429-17ec-4690-929c-81f19329676c.png">


----------------------
## Mission
My mission was to develop a professional application that is able to read a JSON database and represent that as slideshow.

The main focus of the project was to build an application that delivers a package that is extensible and maintainable.

## Core Project

This seemingly simple project is broken down into its smallest units and provides an array of reuseable functions and algorithm.

It also thinks about the users first by implementing UI/UX that is easy to understand and easy to maintain. For example, the application provides the user with an option to keep the screen from going to sleep by putting the application on "Frame Mode", when this is turned on it alerts the user that the screen will now be maintained on. 

Furthermore, when users put the application on background state the Frame Mode turns off and alerts the user again when user activates the application again and turns the Frame Mode on again, the alert is only once per session.

Users can also hide the UI to give it a Frame like view.

Pixel perfect alignment and framinging is provided for different device (iPad vs iPhone) and screen orientation.

Application uses common naming convention to conform to the accessibility features of the iOS. 

Unit tests are also provided for the DataManagers

The following is a breakdown of the project.

* DataManager(ViewModel + Controller) - Parses local database
    *    func loadData(filename) -> Data
    *    func loadJSON(Data, Struct) -> Fills SlideModel
* SlideModel
    * var quote, author, slideTransitionDelay  
* DataManager(ViewModel + Controller) - Parses API data
    *    func fetchImg(url Query) -> Data
    *    let apiKey - custom BASH saved to Info.plist
* imgModel
    *    parses the image URL from unsplash API
* Main View
    *    func idleTimer - enables/diasbles screen timeout, allowing users to use the app as a picture frame
    *    Hideable UI that collapses out of frame on click of the screen
    *    GeometryReader allows adaptible view orientation based on the screen size (Landscape, iPad, iPhone)
    *    func timer reads the transition time frm JSON and executes when it expires
    *    lifecycle events triggered on active and on going into background
    *    cache is cleared on sleep and the UI resets on active.

## Reference
https://unsplash.com/developers
https://swdevnotes.com/swift/2022/read-json-with-codeable-in-swift/
https://www.hackingwithswift.com/books/ios-swiftui/triggering-events-repeatedly-using-a-timer

## Usage
Copyright © 2022 Daehee Hwangs
