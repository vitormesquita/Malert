<img src="https://github.com/vitormesquita/Malert/blob/develop/Malert/Assets/Malert_brand.png">

[![CI Status](http://img.shields.io/travis/Vitor Mesquita/Malert.svg?style=flat)](https://travis-ci.org/Vitor Mesquita/Malert)
[![Version](https://img.shields.io/cocoapods/v/Malert.svg?style=flat)](http://cocoapods.org/pods/Malert)
[![License](https://img.shields.io/cocoapods/l/Malert.svg?style=flat)](http://cocoapods.org/pods/Malert)
[![Platform](https://img.shields.io/cocoapods/p/Malert.svg?style=flat)](http://cocoapods.org/pods/Malert)

## A simple, easy and custom iOS UIAlertView written in Swift 

<img src="https://github.com/vitormesquita/Malert/blob/develop/Malert/Assets/first.gif" width="250">
<img src="https://github.com/vitormesquita/Malert/blob/develop/Malert/Assets/second.gif" width="250">
<img src="https://github.com/vitormesquita/Malert/blob/develop/Malert/Assets/third.gif" width="250">
<img src="https://github.com/vitormesquita/Malert/blob/develop/Malert/Assets/fourthExample.gif" width="250">
<img src="https://github.com/vitormesquita/Malert/blob/master/Malert/Assets/all.gif" width="250">

Malert came to facilitate make custom alert views, introducing as `UIAlertViewController`. Malert allows you make some custom configurations to show your alert as your application layout.
Malert can display one or a queue of alerts and you can to display alert with some animations.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Xcode 8.0+
- Swift 3.0+

## Installation

### Pod

Malert is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Malert"
```
### Manually

If you prefer not to use any dependency managers, you can integrate Malert in your project manually just adding the files which contains [Malert Classes](https://github.com/vitormesquita/Malert/tree/master/Malert/Classes). 

And you will need to add MalertDependencies libraries:

* [Cartography](https://github.com/robb/Cartography)
* [OAStackView](https://github.com/oarrabi/OAStackView)

And congratulations!!! You can run Malert without any dependecy managers

## Example

This is a simple way. If you want to know more, check the repo.

### Default Malert with title

```swift
import Malert

    //Create Buttons
    let button1 = MalertButtonStruct(title: "title1") { 
        //Do something when click at button
    }

    let button2 = MalertButtonStruct(title: "title2") {
        //Do something when click at button
    }

    let button3 = MalertButtonStruct(title: "title3") {
        //Do something when click at button
    }

    //Create Malert with title, custom view, buttons and animation type
    MalertManager.shared.show(title: "title", 
        customView: test.instantiateFromNib(), 
        buttons: [button1, button2, button3], 
        animationType: .modalLeft)
```

### Default Malert without title

```swift
import Malert

    //Create Buttons
    let button1 = MalertButtonStruct(title: "title1") { 
        //Block will call when click on button
    }

    let button2 = MalertButtonStruct(title: "title2") {
        //Block will call when click on button
    }

    //Create Malert with custom view, buttons and animation type
    MalertManager.shared.show(customView: myCustomView, 
        buttons: [button1, button2], 
        animationType: .modalLeft)
```

### How to create buttons 

Malert provides a struct to configure your button, for each button you need to instantiate `MalertButtonStruct`

```swift
    
    //Create button with default background color
    let button = MalertButtonStruct(title: "button with default background") {
        //Block will call when click on button
    }
    
    //Create button with custom background color
    let button2 = MalertButtonStruct(title: "button with custom background", backgroundColor: .red) {
        //Block will call when click on button
    }
```

You can customize single button, passing `MalertButtonConfiguration` containing your custom configurations

```swift
    //Create configuration
    var btConfiguration = MalertButtonConfiguration()
    btConfiguration.tintColor = .white
    btConfiguration.separetorColor = .clear
    
    //Create button and pass configuration
    let thatIsAllFolksButton = MalertButtonStruct(title: "That's all folks", buttonConfiguration: btConfiguration) { 
        //Block will call when click on button
    }

```

## Customize

Malert is very customizable. There are two ways to customize your Malert: 

- [x] Appearece 
- [x] Custom single alert

If all malert in your application is the same, malert provides for you a global customization, and every malert will have the same customization.

```swift
    var malertAppearance = MalertView.appearance()
    malertAppearance.backgroundColor = .gray
    malertAppearance.buttonsAxis = .horizontal
    malertAppearance.margin = 16
```

If you want just customize one malert in you application, you can pass `MalertViewConfiguration` containing your configuration

```swift

    //build your configuration
    var malertConfiguration = MalertViewConfiguration()

    malertConfiguration.backgroundColor = UIColor(red:0.7, green:0.7, blue:1.0, alpha:1.0)
    malertConfiguration.buttonsAxis = .horizontal
    malertConfiguration.textColor = .white
    malertConfiguration.textAlign = .center
    malertConfiguration.margin = 16

    //And pass when you start malert
    MalertManager.shared.show(title: "title", customView: teste.instantiateFromNib(), buttons: [malertButtonConfig], animationType: .modalRight, malertConfiguration: malertConfiguration)
```

## Default values

By default malert provides defaults values:

```swift
    //Defaults attr malertView
    var malertAppearance = MalertView.appearance()

    malertAppearance.backgroundColor    : UIColor                 = .white
    malertAppearance.cornerRadius       : CGFloat                 = 6
    malertAppearance.textColor          : UIColor                 = .black
    malertAppearance.textAlign          : NSTextAlignment         = .left
    malertAppearance.buttonsAxis        : UILayoutConstraintAxis  = .vertical
    malertAppearance.margin             : CGFloat                 = 0
    malertAppearance.titleFont          : UIFont                  = UIFont()
    malertAppearance.buttonsMargin      : CGFloat                 = 0
    malertAppearance.buttonsSpace       : CGFloat                 = 0
```
```swift
    //Defaults attr malertButton
    var malertButtonAppearance = MalertButton.appearance()

    malertButtonAppearence.tintColor       : UIColor = .black
    malertButtonAppearance.backgroundColor : UIColor = .clear
    malertButtonAppearance.height          : CGFloat = 33
    malertButtonAppearance.separatorColor  : UIColor = UIColor(white: 0.8, alpha: 1)
```

## Author

Vitor Mesquita, vitor.mesquita09@gmail.com

## License

Malert is available under the MIT license. See the LICENSE file for more info.
