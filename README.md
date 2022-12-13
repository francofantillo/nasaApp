# Workday
Workday Project

This project's purpose in to expose the search functionality of the NASA Image and Video Library API.

Users type text into the search box in order to see various data objects associated with that keyword.

I try to stick MVVM for the overall architecture of the app.  This can be observed with the details screen.  Data, viewmodel and view are all separted.

In some cases I revert back to using MVC architecture when the view needs to observe StateObjects or ObservedObjects.  The view will not react to
changes in these objects when placed into a viewmodel as viewmodels are often reference types and do not work with SwiftUI architecture (at least when
it comes to updating the view).  I find the best solution here is to have stateobjects and observedobject live on the view struct as well as any code that
interacts with them.  I have also separted networking code into their own classes.  They use dependancy injection in order to properly support testing.  
For this project, my tests focus on testing networking code, mainly the HttpClient.  These can be viewed in the WorkdayTests.swift file.

This project does not use any external libraries.  The only libraries used are internal, in this case SwiftUI and XCTest.

In order to run the app, simply press run from xcode and type your desired text into the search box.

The app will display 100 search items at a time. To see more then 100 items swipe up untill more items appear.  If there are no more to display, nothing 
else will be added to the list.
