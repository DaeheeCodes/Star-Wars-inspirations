# Inspirations - Star Wars Edition
#### By Daehee Hwang


----------------------
## Mission
My mission was to develop a professional application that is able to read a JSON database and represent that as slideshow.

The main focus of the project was to build an application that follows the SOLID principle to deliver an package that is extensible and maintainable

## Core Project

This seemingly simple project is broken down into its smallest units and provides an array of reuseable functions and algorhythms that are reuseable in any SwiftUI projects.

It also follows common naming convention to conform to the accessibility features of the iOS. 

The following is a breakdown of the project.


* DataManager(ViewModel + Controller) - Parses local database
    *    func loadData(filename) -> Data
    *    func loadJSON(Data, Struct) -> Fills SlideModel
* SlideModel
    * var quote, author, slideTransitionDelay  
* DataManager(ViewModel + Controller) - Parses API data
    *    func fetchImg(url Query) -> Data
    *    let apiKey - custom BASH saved to Info.plist
* imgModel1
