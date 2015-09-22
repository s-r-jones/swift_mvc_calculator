//
//  ViewController.swift
//  Calculator
//
//  Created by Sam Jones on 9/17/15.
//  Copyright (c) 2015 Sam Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var display: UILabel!
    
    var userIsTypingANumber: Bool = false
    
    var brain = CalculatorModel()

    @IBAction func append_digit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTypingANumber {
            display.text = display.text! + digit
        }
        else {
            display.text = digit //get rid of the zero
            userIsTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            }else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsTypingANumber = false
        if let result = brain.performOperation(displayValue) {
            displayValue = result
        }else {
            displayValue = 0 //TODO create an error or something better to display
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsTypingANumber = false
        }
    }

}

