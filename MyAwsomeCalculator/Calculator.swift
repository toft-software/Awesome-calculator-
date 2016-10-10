//
//  Calculator.swift
//  MyAwsomeCalculator
//
//  Created by Christian Andersen on 29/09/2016.
//  Copyright © 2016 Christian Andersen. All rights reserved.
//

import Foundation


class Calculator {
    
    init() {
        
    }

    private var numberBeforeDecimal : String!
    private var numberAfterDecimal : String!
    
    private var numberBeforeDecimal1 : String!
    private var numberAfterDecimal1 : String!
    
    private var numberBeforeDecimal2 : String!
    private var numberAfterDecimal2 : String!
    
    private var operationPrevious : calculatorKeys!
    private var operationPrevious1 : calculatorKeys!
    
    var resultAsString: String {
        get {
            if ((numberBeforeDecimal != nil) && (numberAfterDecimal != nil)) {
                return(numberBeforeDecimal+numberAfterDecimal)
            } else  {
                return(numberBeforeDecimal)
            }
        }
        set {
            if let newValueFloat = Float(newValue) {
                let remainder = newValueFloat.truncatingRemainder(dividingBy: 1)
                if (remainder > 0) {
                    numberAfterDecimal = String(remainder).replacingOccurrences(of: "0.", with: ".")
                } else {
                    numberAfterDecimal = nil
                }
                numberBeforeDecimal = String(Int(newValueFloat) )
            }
            
        }
    }
    
    var result1AsString: String {
        get {
            if ((numberBeforeDecimal1 != nil) && (numberAfterDecimal1 != nil) ) {
                return(numberBeforeDecimal1+numberAfterDecimal1)
            } else {
                return(numberBeforeDecimal1)
            }
        }
        set {
            if let newValueFloat = Float(newValue) {
                let remainder = newValueFloat.truncatingRemainder(dividingBy: 1)
                if (remainder > 0) {
                    numberAfterDecimal1 = String(remainder).replacingOccurrences(of: "0.", with: ".")
                    } else {
                    numberAfterDecimal1 = nil
                }
                numberBeforeDecimal1 = String(Int(newValueFloat) )
            }
        }
    }
    
    var result2AsString: String {
        get {
            if ((numberBeforeDecimal2 != nil) && (numberAfterDecimal2 != nil)) {
                return(numberBeforeDecimal2+numberAfterDecimal2)
            } else  {
                return (numberBeforeDecimal2)
            }
        }
        set {
            if let newValueFloat = Float(newValue) {
                let remainder = newValueFloat.truncatingRemainder(dividingBy: 1)
                if (remainder > 0) {
                    numberAfterDecimal2 = String(remainder).replacingOccurrences(of: "0.", with: ".")
                } else {
                    numberAfterDecimal2 = nil
                }
                numberBeforeDecimal2 = String(Int(newValueFloat) )
            }
        }
    }

    
    func Engine(key : calculatorKeys) -> String {
        if (key.rawValue <= calculatorKeys.comma.rawValue) { //Number
            if (key.rawValue == calculatorKeys.comma.rawValue) { //comma
                if (numberBeforeDecimal == nil) {
                    numberBeforeDecimal = "0"
                }
                numberAfterDecimal = "."
            }
            else {
                if (numberAfterDecimal == nil) {
                    if (numberBeforeDecimal == nil) {
                        numberBeforeDecimal = String(key.rawValue)
                    }
                    else {
                        numberBeforeDecimal = numberBeforeDecimal + String(key.rawValue)
                    }
                } else {
                    numberAfterDecimal =  numberAfterDecimal + String(key.rawValue)
                }
            }
            return resultAsString
        }
        else if ((key.rawValue >= calculatorKeys.plus.rawValue) && (key.rawValue <= calculatorKeys.equal.rawValue)) {
            
            
            if (numberBeforeDecimal == nil  &&  numberAfterDecimal == nil) {
                operationPrevious = key
                return ""
            }
            // calc operator
            if (operationPrevious==nil) {
                numberBeforeDecimal1 = numberBeforeDecimal
                numberAfterDecimal1 = numberAfterDecimal
                operationPrevious = key
                numberBeforeDecimal=nil
                numberAfterDecimal=nil
            } else if (operationPrevious1==nil) {
                numberBeforeDecimal2 = numberBeforeDecimal1
                numberAfterDecimal2 = numberAfterDecimal1
                operationPrevious1 = operationPrevious
                numberBeforeDecimal1 = numberBeforeDecimal
                numberAfterDecimal1 = numberAfterDecimal
                numberBeforeDecimal=nil
                numberAfterDecimal=nil
            }
            
           
            if ((operationPrevious1 != nil)  ) {
                var NewResult : Float = 0
                if let r2 = Float(result2AsString) , let r1 = Float(result1AsString) {
                    if (operationPrevious == calculatorKeys.plus) {
                        NewResult = r2 + r1
                    } else if (operationPrevious == calculatorKeys.minus) {
                        NewResult = r2 - r1
                    } else if (operationPrevious == calculatorKeys.multiply) {
                        NewResult = r2 * r1
                    } else if (operationPrevious == calculatorKeys.divide) {
                        NewResult = r2 / r1
                    }
                    
                }
                initialize()
                result1AsString = String(NewResult)
                operationPrevious = key
                return (result1AsString)
            }
        }
        return ""
    }
    
    
    func getResult(key : calculatorKeys) -> String {
        return Engine(key : key) //let the engine work
    }
    
    func initialize()  {
        numberBeforeDecimal = nil
        numberAfterDecimal = nil
        numberBeforeDecimal1 = nil
        numberAfterDecimal1 = nil
        numberBeforeDecimal2 = nil
        numberAfterDecimal2 = nil

        operationPrevious=nil
        operationPrevious1=nil
    }

}
