import UIKit

class CalculatorViewController: UIViewController {

    //
    // Outlets
    //
    
    @IBOutlet weak var display: UILabel!
    
    //
    // Computed Properties
    //
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
        }
    }
    
    //
    // Properties
    //
    
    var userIsTyping = false
    var operandStack = Array<Double>()
    
    //
    // Actions
    //
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        
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
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        switch operation {
        case "+": performOperation {(num1, num2) in num1 + num2 }
        case "-": performOperation {(num1, num2) in num1 - num2 }
        case "x": performOperation {(num1, num2) in num1 * num2 }
        case "÷": performOperation {(num1, num2) in num1 / num2}
        case "√": performOperation {(num) in sqrt(num)}
        default: break
        }
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
    
}

