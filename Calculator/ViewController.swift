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
    // IBOutlet weak var display: UILabel?  // display is an Optional UILabel
    @IBOutlet weak var display: UILabel!     // ! says display is an Optional, but unwrap it automatically. Called 'Implicitly unwrapped optional'
    
    // computed property
    var displayValue: Double {
        get {
            // return Double(display.text!.toInt()!)
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }
    
    // var userIsTyping: Bool = false  // instance variable set to false
    var userIsTyping = false
    
    // var operandStack: Array<Double> = Array<Double>()
    var operandStack = Array<Double>()  // using type inference
    
    // type touchUpInside
    // IBAction func appendDigit(sender: UIButton) -> Double {  //example return
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!  // String? type. Optional String. This var is an Optional and if it is set, it is a String.
                                         // the ! unwraps the optional. i.e. returns the string
        println("digit = \(digit)")
        if(userIsTyping == false) {
          display.text = ""
        }
        display.text = display.text! + digit
        userIsTyping = true
    }

    @IBAction func enter() {
        operandStack.append(displayValue)
        userIsTyping = false
        println("stack = \(operandStack)")
    }
    
    //
    // Operations
    //
    
    func performOperation(operation: (Double, Double) -> Double) {
        userIsTyping = false
        if operandStack.count >= 2 {
            let num1 = operandStack.removeLast()
            let num2 = operandStack.removeLast()
            displayValue = operation(num1, num2)
            enter()
        }
    }
    
    func performOperation(operation: (Double) -> Double) {
        userIsTyping = false
        if operandStack.count >= 1 {
            let num = operandStack.removeLast()
            displayValue = operation(num)
            enter()
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
        case "+": performOperation({(num1:Double, num2:Double) -> Double in  // using full signature
            return num1 + num2
        })
        case "-": performOperation({(num1, num2) in  // using type inference
            return num1 - num2
        })
        case "x": performOperation({(num1, num2) in num1 * num2 }) // can omit the return keyword
        case "÷": performOperation {$0 / $1}  // since the operation clojure is the only argument you can move the function outside
        case "√": performOperation {sqrt($0)}
        default: break
        }
    }
}

