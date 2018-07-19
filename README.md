<div style="text-align: center"> 
	<img src="https://github.com/vitormesquita/Malert/blob/develop/Malert/Assets/Malert_brand.png">
</div>

[![Version](https://img.shields.io/cocoapods/v/Malert.svg?style=flat)](http://cocoapods.org/pods/Malert)
[![License](https://img.shields.io/cocoapods/l/Malert.svg?style=flat)](http://cocoapods.org/pods/Malert)
[![Platform](https://img.shields.io/cocoapods/p/Malert.svg?style=flat)](http://cocoapods.org/pods/Malert)

## A simple, easy and custom iOS UIAlertView written in Swift 

<div style="text-align: center"> 
	<img src="https://github.com/vitormesquita/Malert/blob/develop/Malert/Assets/mockup.png">
</div>

Malert came to facilitates custom alert views as `UIAlertController`. Malert allows you to personalize your alertView so that it matches your application layout

<!--Malert can display one or a queue of alerts and you can also display alert with some animations-->

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Xcode 9.0+
- Swift 4.0+

## Versioning

- *Swift 3.x*: 1.1.5
- *Swift 4*: 2.0+

## Installation

### Pod

Malert is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Malert'
```
### Manually

If you don't use any dependency managers, you can integrate Malert in your project manually just adding the files which contains [Malert Classes](https://github.com/vitormesquita/Malert/tree/master/Malert/Classes). 

Congratulations!!! You can run Malert without any dependency managers!

## Example

This is a simple example. If you want to know more, check the app Example cause There are more than 10 customizated Malerts.

### Default Malert with title

```swift
import Malert

	...
	
	TODO
	
	...
	
```

### Default Malert without title

```swift
import Malert

	...

   	TODO
    
   	...
   	
```

### How to create buttons 

To add buttons to your malert There is a function called `addAction` that you need to provide a `MalertAction` object to build customizable buttons.

```swift
    let malert = ... 
    
    let action = MalertAction(title: "Take the tour")
    action.cornerRadius = 8
    action.tintColor = .white
    action.backgroundColor = UIColor(red:0.38, green:0.76, blue:0.15, alpha:1.0)
	
	malert.addAction(action)
	
	...
```

You can customize a button changing `MalertAction` attributes:

```swift
    public var tintColor: UIColor
    public var cornerRadius: CGFloat
    public var backgroundColor: UIColor
```

For more details check the examples :D

## Customize

Malert is very customizable. There are two ways to customize your Malert: 

- [x] Appearece 
- [x] Custom single alert

If all malerts in your application will be the same, malert provides a global customization option, and every malert will have the same customization.

```swift
    var malertAppearance = MalertView.appearance()
    malertAppearance.backgroundColor = .gray
    malertAppearance.buttonsAxis = .horizontal
    malertAppearance.margin = 16
```

If you want to just customize one malert, you can change almost all attributes!!!

```swift

    //customizing your malert
    TODO
    
```

## Default values

By default malert provides values:

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

###[CHANGELOG](https://github.com/vitormesquita/Malert/blob/master/CHANGELOG.md)

## Author

Vitor Mesquita, vitor.mesquita09@gmail.com

## License

Malert is available under the MIT license. See the LICENSE file for more info.
