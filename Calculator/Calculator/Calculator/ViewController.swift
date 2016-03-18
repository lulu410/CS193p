//
//  ViewController.swift
//  Calculator
//
//  Created by Madison on 3/9/16.
//  Copyright © 2016 Madison. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isTyping:Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if isTyping{
            display.text = display.text! + digit
        }
        else{
            display.text = digit
            isTyping = true
        }
    }
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if isTyping{
            enter()
        }
        switch operation{
        case "✖️": performOperation {$0 * $1}
        case "➗": performOperation {$1 / $0}
        case "➖": performOperation {$1 - $0}
        case "➕": performOperation {$0 + $1}
        case "⎷" : performOperation1 {sqrt($0)}
        default: break
        }
    }
    func performOperation(operation: (Double, Double) -> Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func performOperation1(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }

    
    
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        isTyping = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    var displayValue: Double{
        get{
            print("display is \(NSNumberFormatter().numberFromString(display.text!)!)")
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            isTyping = false
        }
    }

}

