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
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        var isTyping: Bool = false
        if isTyping{
            display.text = display.text! + digit
        }
        else{
            display.text = digit
            isTyping = true
        }
    }

}

