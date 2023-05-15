# Workday
Workday Project

This project's purpose in to expose the search functionality of the NASA Image and Video Library API.

Users type text into the search box in order to see various data objects associated with that keyword.

I chose to use MVVM for the overall architecture of the app. Model, Viewmodel and view are all separted.

I have also separted networking code into their own classes.  They use dependancy injection in order to properly support testing.  
    
For this project, my tests focus on testing networking code and the viewmodel code. These can be viewed in the NetworkTests.swift and ViewModelTests.swift file.

This project does not use any external libraries.  The only libraries used are internal, in this case SwiftUI and XCTest.

In order to run the app, simply press run from xcode and type your desired text into the search box.

The app will display 100 search items at a time. To see more then 100 items swipe up until more items appear.  If there are no more to display, nothing
    else will be added to the list.
