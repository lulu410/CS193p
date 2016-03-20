//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Madison on 3/18/16.
//  Copyright © 2016 Madison. All rights reserved.
//

import Foundation

class CalculatorBrain{
    enum Op: CustomStringConvertible{
        case Operand(Double)
        case UnaryOperation(String, Double -> Double)
        case BinaryOperation(String, (Double, Double) -> Double)
        
        var discription: String{
            get{
                switch self{
                case .Operand(let operand):
                    return "\(operand)"
                case .BinaryOperation(let symbol, _):
                    return "\(symbol)"
                case .UnaryOperation(let symbol, _):
                    return "\(symbol)"
                }
            }
        }
    }
    private var opStack = [Op]()
    private var knowOps = [String: Op]()
    init(){
        //print("go here")
        knowOps["➕"] = Op.BinaryOperation("➕", +)
        knowOps["✖️"] = Op.BinaryOperation("✖️", *)
        knowOps["➖"] = Op.BinaryOperation("➖") {$1 - $0}
        knowOps["➗"] = Op.BinaryOperation("➗") {$1 / $0}
        knowOps["⎷"] = Op.UnaryOperation("⎷", sqrt)
    }
    
    private func evalute(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty{
            var remaingingOps = ops
            let op = remaingingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return (operand, remaingingOps)
            case .UnaryOperation(_, let operation):
                let operandEvalution = evalute(remaingingOps)
                if let operand = operandEvalution.result{
                    return (operation(operand), operandEvalution.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evalution = evalute(remaingingOps)
                if let operand1 = op1Evalution.result{
                    let op2Evalution = evalute(op1Evalution.remainingOps)
                    if let operand2 = op2Evalution.result{
                        return (operation(operand1, operand2), op2Evalution.remainingOps)
                    }
                }
            
            }
        }
        print("here")
        return (nil, ops)
    }
    
    func evalute() -> Double? {
        let (result, _) = evalute(opStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
       // print(opStack)
        return evalute()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knowOps[symbol]{
            opStack.append(operation)
        }
        return evalute()
    }
}
