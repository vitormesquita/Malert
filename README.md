<img src="https://github.com/vitormesquita/Malert/blob/develop/Malert/Assets/Malert_brand.png" width="300">

[![CI Status](http://img.shields.io/travis/Vitor Mesquita/Malert.svg?style=flat)](https://travis-ci.org/Vitor Mesquita/Malert)
[![Version](https://img.shields.io/cocoapods/v/Malert.svg?style=flat)](http://cocoapods.org/pods/Malert)
[![License](https://img.shields.io/cocoapods/l/Malert.svg?style=flat)](http://cocoapods.org/pods/Malert)
[![Platform](https://img.shields.io/cocoapods/p/Malert.svg?style=flat)](http://cocoapods.org/pods/Malert)

## A simple iOS dialog View, customizable dialog View and written in Swift 

Malert came to facilitate make custom alert views, introducing as `UIAlertViewController`. Malert allows you make some custom configurations to show your alert as your application layout.
Malert can display one or a queue of alerts and you can to display alert with some animations.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Xcode 8.0+
- Swift 3.0+

## Installation

Malert is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Malert"
```
###Example

This is a simple way. If you want to know more, check the repo.

## Default Alert with title

```swift
import Malert

    //Create Buttons
    let button1 = MalertButtonConfig(title: "teste", type: .normal, enable: true) { 
        //Do something when click at button
    }

    let button2 = MalertButtonConfig(title: "teste2 ", type: .normal, enable: true) {
        //Do something when click at button
    }

    let button3 = MalertButtonConfig(title: "teste3 ", type: .normal, enable: true) {
        //Do something when click at button
    }

    //Create Dialog with title, custom view, buttons and animation type
    MalertManager.shared.show(title: "titulo", 
customView: test.instantiateFromNib(), 
buttons: [button1, button2, button3], 
animationType: .modalLeft)
```

## Default Alert without title

```swift
import Malert 

    //Create Buttons
    let button1 = MalertButtonConfig(title: "teste", type: .normal, enable: true) { 
        //Do something when click at button
    }

    let button2 = MalertButtonConfig(title: "teste2 ", type: .normal, enable: true) {
        //Do something when click at button
    }

    //Create Dialog with custom view, buttons and animation type
    MalertManager.shared.show(customView: teste.instantiateFromNib(), 
buttons: [button1, button2], 
animationType: .modalLeft)

```


## Author

Vitor Mesquita, vitor.mesquita09@jera.com.br

## License

Malert is available under the MIT license. See the LICENSE file for more info.
