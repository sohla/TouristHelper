# TouristHelper

Tourist Helper is a simple app uses Google Places API to find locations around the device's current location. It is far from complete and is more a proof of concept.
Basic functionality include :
- Location Services : get current device location
- Places : based on a type, locations are places on the map and  a path is generated from the current location, visiting all the locations and returing back to the start.


### Simulator

When using the simulator, you can set the devices location in the Debug menu.
Tap *Home* in the app to update to current location.

### CocoaPods

This app relies on a few libraries :

- ReativeKit / Bond : being new to these libraries and paradigm, improvements could be made. I am enjoying how much cleaner and expressive my code can become. I have still a lot to learn including the API and used up more time than anything else.
- SwiftLocation : this lib. looked handy for dealing with some of the edge cases around the device's location services including device type and iOS version. i have yet to test some of these features. This could easily be replaced with another library or a custom CLLocationManager class.
- Networking : there are many libraries to deal with NSURLSession. This seemed small and simple and had an interface that served my needs. With more time i would abstract this layer so i could replace with *any* library.


### Installation

Project includes pods. To update pods, use ```pod update``` in project folder.



