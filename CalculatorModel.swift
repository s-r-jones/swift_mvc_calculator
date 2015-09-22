//
//  CalculatorModel.swift
//  Calculator
//
//  Created by Sam Jones on 9/21/15.
//  Copyright © 2015 Sam Jones. All rights reserved.
//

import Foundation

class CalculatorModel
{
    private enum Op {
        case Operand(Double)
        case SingleOperation (String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
    }
    
    private var opStack = [Op]()
    
    //look up string symbol in Dictionary, eg "x," to know what math to do
    private var knownOps = [String: Op]()
    
    init(){
        knownOps[]
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){
        
        if !ops.isEmpty{
            // make ops mutable - arrays and strucks are not classes in swift they are passed by value
            //swift is super smart so we aren't really copying this three times
            var remainingOps = ops
            // only makes a copy here. Swift does the min amount of copying
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .SingleOperation(_, let operation):
                let operandEval = evaluate(remainingOps)
                if let operand = operandEval.result {
                    return (operation(operand), operandEval.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let operand1Eval = evaluate(remainingOps)
                if let operand1 = operand1Eval.result {
                    let operand2Eval = evaluate(operand1Eval.remainingOps)
                    if let operand2 = operand2Eval.result {
                        return (operation(operand1, operand2), operand2Eval.remainingOps)
                    }
                }
            }
        }
        //base case
        return (nil, ops)
    }
    
    //iterate through stack recursively using helper function
    func evaluate() -> Double? {
        let (result, _) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String){
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
    }
}