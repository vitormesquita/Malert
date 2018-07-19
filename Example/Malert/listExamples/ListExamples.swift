//
//  ListExamples.swift
//  Malert_Example
//
//  Created by Vitor Mesquita on 18/07/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Malert

extension ListExamplesViewController {

    func addExamples() {
        addExample1()
        addExample2()
        addExample3()
        addExample4()
    }

    private func addExample1() {
        let firstExample = FirstCustomView.instantiateFromNib()
        firstExample.populate(title: "Hello!", message: "There are a lot of ways to build a Malert :)")

        let alert = Malert(customView: firstExample)

        let action = MalertAction(title: "OK")
        action.tintColor = UIColor(red:0.15, green:0.64, blue:0.85, alpha:1.0)
        alert.addAction(action)

        examples.append(Example(title: "Example 1", malert: alert))
    }

    private func addExample2() {
        let example2View = Example2View.instantiateFromNib()

        let alert = Malert(customView: example2View)
        alert.animationType = .modalLeft
        alert.backgroundColor = UIColor(red:0.47, green:0.53, blue:0.80, alpha:1.0)
        alert.buttonsAxis = .horizontal
        alert.buttonsHeight = 60
        alert.separetorColor = .clear

        let buttonsColor = UIColor(red:0.36, green:0.42, blue:0.75, alpha:1.0)

        let firstAction = MalertAction(title: "GOT IT", backgroundColor: buttonsColor)
        firstAction.tintColor = .white
        alert.addAction(firstAction)

        let secondAction = MalertAction(title: "LOOK UP", backgroundColor: buttonsColor)
        secondAction.tintColor = .white
        alert.addAction(secondAction)

        examples.append(Example(title: "Example 2", malert: alert))
    }

    private func addExample3() {
        let example3View = Example3View.instantiateFromNib()

        let alert = Malert(customView: example3View)
        alert.animationType = .modalRight
        alert.buttonsAxis = .horizontal
        alert.buttonsSideMargin = 60
        alert.buttonsBottomMargin = 16
        alert.separetorColor = .clear

        let firstAction = MalertAction(title: "Take the tour")
        firstAction.backgroundColor = UIColor(red:0.38, green:0.76, blue:0.15, alpha:1.0)
        firstAction.tintColor = .white
        firstAction.cornerRadius = 8
        alert.addAction(firstAction)

        examples.append(Example(title: "Example 3", malert: alert))
    }
    
    private func addExample4() {
        let example4View = Example4View.instantiateFromNib()
        
        let alert = Malert(customView: example4View, tapToDismiss: false)
        alert.buttonsAxis = .horizontal
        alert.separetorColor = .clear
        alert.cornerRadius = 20
        alert.animationType = .fadeIn
        alert.presentDuration = 0.6
        
        let firstAction = MalertAction(title: "SNOOZE") {
            print("snooze")
        }
        
        firstAction.tintColor = UIColor.lightGray
        alert.addAction(firstAction)
        
        let secondAction = MalertAction(title: "JOIN THE GAME")
        secondAction.tintColor = UIColor(red:0.91, green:0.12, blue:0.39, alpha:1.0)
        alert.addAction(secondAction)
        
        examples.append(Example(title: "Example 4", malert: alert))
    }
}
