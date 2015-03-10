//
//  ViewController.swift
//  Calculator
//
//  Created by Monica on 2015-03-09.
//  Copyright (c) 2015 Monica. All rights reserved.
//

import UIKit

// TODO: Rename this to CalculatorViewController
class ViewController: UIViewController {

    // properies (instance variables)
    // IBOutlet is not part of swift. It's an annotation added by XCode.
    // declare a variable called display of type UILabel when dragging and dropping
    @IBOutlet weak var display: UILabel!     // ! says display is an Optional, but unwrap it automatically. Called 'Implicitly unwrapped optional'
    // IBOutlet weak var display: UILabel?  // display is an Optional UILabel
    
    var userIsTyping: Bool = false  // instance variable set to false
    
    // type touchUpInside
    // IBAction func appendDigit(sender: UIButton) -> Double {  //example return
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!  // String? type. Optional String. This var is an Optional and if it is set, it is a String.
                                         // the ! unwraps the optional. i.e. returns the string
        println("digit = \(digit)")
        if(display.text! == "0") {
          display.text = ""
        }
        display.text = display.text! + digit
    }

}

