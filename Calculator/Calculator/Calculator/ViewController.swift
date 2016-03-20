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
    var brain = CalculatorBrain()
    
    @IBAction func appendfDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        //print(isTyping)
        if isTyping{
            display.text = display.text! + digit
        }
        else{
            display.text = digit
            isTyping = true
          //  print(isTyping)
        }
    }
    @IBAction func operate(sender: UIButton) {
        
        if isTyping{
            enter()
        }
        
        if let operation = sender.currentTitle{
            print("operation is =\(brain.performOperation(operation))")
            if let result = brain.performOperation(operation){print("here")
                displayValue = result
            }else{
                displayValue = 0
            }
        }
    }
    
    
    @IBAction func enter() {
        isTyping = false
        print("operand is = \(brain.pushOperand(displayValue))")
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    
    }
    var displayValue: Double{
        get{
            print("display is \(NSNumberFormatter().numberFromString(display.text!)!)")
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            
        }
    }

}

