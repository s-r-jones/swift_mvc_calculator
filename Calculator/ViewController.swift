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
        let operation = sender.currentTitle!
        
        if userIsTypingANumber {
            enter()
        }
        switch operation {
            //example of a closure & type inference - neat  swift feature
            case "✕": performOperation({$0 * $1})
            case "÷": performOperation({$1 * $0})
            case "＋": performOperation({$0 + $1})
            case "－": performOperation({$1 - $0})
            case "√": performOperation({sqrt($0)})
            default: break
        }
    }
    
    func performOperation(operation: (Double,Double) -> Double){
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    private func performOperation(operation: Double -> Double){
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userIsTypingANumber = false
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
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

