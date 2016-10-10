//
//  CalculatorView.swift
//  MyAwsomeCalculator
//
//  Created by Christian Andersen on 01/10/2016.
//  Copyright © 2016 Christian Andersen. All rights reserved.
//

import Foundation
import UIKit

protocol CalculatorKeyPressedDelegate {
    func keyPressed(Key : calculatorKeys)
}

public enum calculatorKeys : NSInteger {
    case zero = 0, one , two, three, four, five, six, seven, eight, nine, comma, plus, minus , divide , multiply, equal
}

class CalculatorView  : UIView {

    var delegate:CalculatorKeyPressedDelegate? = nil
    
    private let toppadding = 150
    private let leftpadding = 23
    private let padding = 15
    private let butwidth = 70
    private let butheight = 70
    
    private var resultLabel :UILabel!
    
    var plusBut : UIButton!
    var oneBut : UIButton!
    
    private var initializeState=false
    
    var colorNumberBut = UIColor.green
    var colorNumberButShade = UIColor.darkGray
    
    var coloroperatorBut = UIColor.red
    var coloroperatorButShade = UIColor.darkGray
    
    var selectorOperator : CalculatorRect!
    var selectorNumber : CalculatorRect!
    
    var calculatorDisplayFrameRect : CGRect!
    
    public var ShakeMeImageView = UIImageView()
    
    var Result: String {
        get {
            return resultLabel.text!
        }
        set {
            resultLabel.text = newValue
            resultLabel.sizeToFit()
            resultLabel.frame = CGRect(x : Int(plusBut.frame.origin.x+(plusBut.frame.width/2))-Int(resultLabel.frame.width), y : Int(calculatorDisplayFrameRect.origin.y) - 5, width: Int(resultLabel.frame.width)+1 , height:  butheight)
        }
    }

    func initialize () {
        resultLabel.text = "0"
        resultLabel.sizeToFit()
 
        resultLabel.frame = CGRect(x : Int(plusBut.frame.origin.x+(plusBut.frame.width/2))-Int(resultLabel.frame.width), y : Int(calculatorDisplayFrameRect.origin.y) - 5, width: Int(resultLabel.frame.width) , height:  butheight)
    
        initializeState=true

    }
    
    func numberPressed (sender : AnyObject){
        let numBut = sender as! UIButton

        selectorNumber.frame =  numBut.frame
        selectorNumber.Show()
        selectorOperator.Hide()
        
        //Only one comma
        if (numBut.tag == calculatorKeys.comma.rawValue) {
            if (resultLabel.text?.contains("."))!{
                return
            }
        }
        
        //Not Zero twice
        if (numBut.tag == calculatorKeys.zero.rawValue) {
            if (resultLabel.text=="0") {
                return
            }
        }
        
        if (delegate != nil) {
            delegate!.keyPressed(Key: calculatorKeys(rawValue: numBut.tag)!)
        }
        
        initializeState=false
        
    }
    
    func OperatorPressed (sender : AnyObject){
        let operatorBut = sender as! UIButton
        
        selectorOperator.frame =  operatorBut.frame
        selectorOperator.Show()
        selectorNumber.Hide()
        
        if (initializeState) {
            return
        }
        
        if (delegate != nil) {
            delegate!.keyPressed(Key: calculatorKeys(rawValue: operatorBut.tag)!)
        }
        
    }

    override init (frame : CGRect){
        super.init(frame: frame)
        
        //Background
        self.backgroundColor = UIColor.clear
        
        //Make Number buttons
        oneBut = UIButton(type: UIButtonType.custom) as UIButton

        oneBut.setImage(StyleKitCalculator.imageOfOnenormal(),for : UIControlState.normal)
        oneBut.setImage(StyleKitCalculator.imageOfOnepressed(),for : UIControlState.highlighted)
        oneBut.frame = CGRect(x: leftpadding, y: toppadding, width: butwidth, height: butheight)
        oneBut.tag = calculatorKeys.one.rawValue
        oneBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        let twoBut = UIButton(type: UIButtonType.custom) as UIButton
        twoBut.setImage(StyleKitCalculator.imageOfTwonormal(),for : UIControlState.normal)
        twoBut.setImage(StyleKitCalculator.imageOfTwopressed(),for : UIControlState.highlighted)
        twoBut.frame = CGRect(x: Int(oneBut.frame.origin.x + oneBut.frame.width)+padding, y: toppadding, width: butwidth, height: butheight)
        twoBut.tag = calculatorKeys.two.rawValue
        twoBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        let threeBut = UIButton(type: UIButtonType.custom) as UIButton
        threeBut.setImage(StyleKitCalculator.imageOfThreenormal(),for : UIControlState.normal)
        threeBut.setImage(StyleKitCalculator.imageOfThreepressed(),for : UIControlState.highlighted)
        threeBut.frame = CGRect(x: Int(twoBut.frame.origin.x + twoBut.frame.width)+padding, y: toppadding, width: butwidth, height: butheight)
        threeBut.tag = calculatorKeys.three.rawValue
        threeBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        plusBut = UIButton(type: UIButtonType.custom) as UIButton
        plusBut.setImage(StyleKitCalculator.imageOfAddnormal(),for : UIControlState.normal)
        plusBut.setImage(StyleKitCalculator.imageOfAddPressed(),for : UIControlState.highlighted)
        plusBut.frame = CGRect(x: Int(threeBut.frame.origin.x + threeBut.frame.width)+padding, y: toppadding, width: butwidth, height: butheight)
        plusBut.tag = calculatorKeys.plus.rawValue
        plusBut.addTarget(self, action: #selector(self.OperatorPressed), for: UIControlEvents.touchUpInside)
        
        
        let fourBut = UIButton(type: UIButtonType.custom) as UIButton
        fourBut.setImage(StyleKitCalculator.imageOfFournormal(),for : UIControlState.normal)
        fourBut.setImage(StyleKitCalculator.imageOfFourpressed(),for : UIControlState.highlighted)
        fourBut.frame = CGRect(x: leftpadding, y: Int(oneBut.frame.origin.y+oneBut.frame.height)+padding, width: butwidth, height: butheight)
        fourBut.tag = calculatorKeys.four.rawValue
        fourBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        let fiveBut = UIButton(type: UIButtonType.custom) as UIButton
        fiveBut.setImage(StyleKitCalculator.imageOfFivenormal(),for : UIControlState.normal)
        fiveBut.setImage(StyleKitCalculator.imageOfFivepressed(),for : UIControlState.highlighted)
        fiveBut.frame = CGRect(x: Int(fourBut.frame.origin.x + fourBut.frame.width)+padding, y: Int(twoBut.frame.origin.y+twoBut.frame.height)+padding, width: butwidth, height: butheight)
        fiveBut.tag = calculatorKeys.five.rawValue
        fiveBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        let sixBut = UIButton(type: UIButtonType.custom) as UIButton
        sixBut.setImage(StyleKitCalculator.imageOfSixnormal(),for : UIControlState.normal)
        sixBut.setImage(StyleKitCalculator.imageOfSixpressed(),for : UIControlState.highlighted)
        sixBut.frame = CGRect(x: Int(fiveBut.frame.origin.x + fiveBut.frame.width)+padding, y: Int(threeBut.frame.origin.y+threeBut.frame.height)+padding, width: butwidth, height: butheight)
        sixBut.tag = calculatorKeys.six.rawValue
        sixBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        let minusBut = UIButton(type: UIButtonType.custom) as UIButton
        minusBut.setImage(StyleKitCalculator.imageOfMinusnormal(),for : UIControlState.normal)
        minusBut.setImage(StyleKitCalculator.imageOfMinusPressed(),for : UIControlState.highlighted)
        minusBut.frame = CGRect(x: Int(sixBut.frame.origin.x + sixBut.frame.width)+padding, y: Int(plusBut.frame.origin.y+plusBut.frame.height)+padding, width: butwidth, height: butheight)
        minusBut.tag = calculatorKeys.minus.rawValue
        minusBut.addTarget(self, action: #selector(self.OperatorPressed(sender:)), for: UIControlEvents.touchUpInside)
        
       
        let sevenBut = UIButton(type: UIButtonType.custom) as UIButton
        sevenBut.setImage(StyleKitCalculator.imageOfSevennormal(),for : UIControlState.normal)
        sevenBut.setImage(StyleKitCalculator.imageOfSevenpressed(),for : UIControlState.highlighted)
        sevenBut.frame = CGRect(x: leftpadding, y: Int(fourBut.frame.origin.y+fourBut.frame.height)+padding, width: butwidth, height: butheight)
        sevenBut.tag = calculatorKeys.seven.rawValue
        sevenBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        let eightBut = UIButton(type: UIButtonType.custom) as UIButton
        eightBut.setImage(StyleKitCalculator.imageOfEightnormal(),for : UIControlState.normal)
        eightBut.setImage(StyleKitCalculator.imageOfEightpressed(),for : UIControlState.highlighted)
        eightBut.frame = CGRect(x: Int(sevenBut.frame.origin.x + sevenBut.frame.width)+padding, y: Int(fiveBut.frame.origin.y+fiveBut.frame.height)+padding, width: butwidth, height: butheight)
        eightBut.tag = calculatorKeys.eight.rawValue
        eightBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        let nineBut = UIButton(type: UIButtonType.custom) as UIButton
        nineBut.setImage(StyleKitCalculator.imageOfNinenormal(),for : UIControlState.normal)
        nineBut.setImage(StyleKitCalculator.imageOfNinepressed(),for : UIControlState.highlighted)
        nineBut.frame = CGRect(x: Int(eightBut.frame.origin.x + eightBut.frame.width)+padding, y: Int(sixBut.frame.origin.y+sixBut.frame.height)+padding, width: butwidth, height: butheight)
        nineBut.tag = calculatorKeys.nine.rawValue
        nineBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        let multiplyBut = UIButton(type: UIButtonType.custom) as UIButton
        multiplyBut.setImage(StyleKitCalculator.imageOfMuliplynormal(),for : UIControlState.normal)
        multiplyBut.setImage(StyleKitCalculator.imageOfMultiplypressed(),for : UIControlState.highlighted)
        multiplyBut.frame = CGRect(x: Int(nineBut.frame.origin.x + nineBut.frame.width)+padding, y: Int(minusBut.frame.origin.y+minusBut.frame.height)+padding, width: butwidth, height: butheight)
        multiplyBut.tag = calculatorKeys.multiply.rawValue
        multiplyBut.addTarget(self, action: #selector(self.OperatorPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        let zeroBut = UIButton(type: UIButtonType.custom) as UIButton
        zeroBut.setImage(StyleKitCalculator.imageOfZeronormal(),for : UIControlState.normal)
        zeroBut.setImage(StyleKitCalculator.imageOfZeropressed(),for : UIControlState.highlighted)
        zeroBut.frame = CGRect(x: leftpadding, y: Int(sevenBut.frame.origin.y+sevenBut.frame.height)+padding, width: butwidth, height: butheight)
        zeroBut.tag = calculatorKeys.zero.rawValue
        zeroBut.addTarget(self, action: #selector(self.numberPressed), for: UIControlEvents.touchUpInside)
        
        let commaBut = UIButton(type: UIButtonType.custom) as UIButton
        commaBut.setImage(StyleKitCalculator.imageOfCommanormal(),for : UIControlState.normal)
        commaBut.setImage(StyleKitCalculator.imageOfCommaPressed(),for : UIControlState.highlighted)
        commaBut.frame = CGRect(x: Int(zeroBut.frame.origin.x + zeroBut.frame.width)+padding, y: Int(sevenBut.frame.origin.y+sevenBut.frame.height)+padding, width: butwidth, height: butheight)
        commaBut.tag = calculatorKeys.comma.rawValue
        commaBut.addTarget(self, action: #selector(self.numberPressed(sender:)), for: UIControlEvents.touchUpInside)
     
        let equalBut = UIButton(type: UIButtonType.custom) as UIButton
        equalBut.setImage(StyleKitCalculator.imageOfEqualnormal(),for : UIControlState.normal)
        equalBut.setImage(StyleKitCalculator.imageOfEqualpressed(),for : UIControlState.highlighted)
        equalBut.frame = CGRect(x: Int(commaBut.frame.origin.x + commaBut.frame.width)+padding, y: Int(nineBut.frame.origin.y+nineBut.frame.height)+padding, width: butwidth, height: butheight)
        equalBut.tag = calculatorKeys.equal.rawValue
        equalBut.addTarget(self, action: #selector(self.OperatorPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        let divideBut = UIButton(type: UIButtonType.custom) as UIButton
        divideBut.setImage(StyleKitCalculator.imageOfDividenormal(),for : UIControlState.normal)
        divideBut.setImage(StyleKitCalculator.imageOfDividepressed(),for : UIControlState.highlighted)
        divideBut.frame = CGRect(x: Int(equalBut.frame.origin.x + equalBut.frame.width)+padding, y: Int(multiplyBut.frame.origin.y+multiplyBut.frame.height)+padding, width: butwidth, height: butheight)
        divideBut.tag = calculatorKeys.divide.rawValue
        divideBut.addTarget(self, action: #selector(self.OperatorPressed(sender:)), for: UIControlEvents.touchUpInside)
        
        resultLabel = UILabel()
        resultLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 35)
        resultLabel.textColor = UIColor.black;

        //Selectors
        selectorOperator = CalculatorRect(strokewidth: 3)
        selectorNumber = CalculatorRect(strokewidth: 3, strokecolor: UIColor.red)
        
        //Frame Calculator
        let calculatorFrameRect = CGRect(x: oneBut.frame.origin.x-10, y: CGFloat(toppadding-100), width: plusBut.frame.origin.x + plusBut.frame.width , height : zeroBut.frame.origin.y + zeroBut.frame.height )
        

        let calculatorFrame = CalculatorRect(strokewidth: 4, strokecolor: UIColor.black, fillcolor : UIColor.gray)
        calculatorFrame.frame = calculatorFrameRect
        
        //Frame Result
        calculatorDisplayFrameRect = CGRect(x : calculatorFrameRect.origin.x+20, y: calculatorFrameRect.origin.y+20, width : calculatorFrameRect.width-40, height : CGFloat(butheight-10))
        
        let calculatorDisplayFrame = CalculatorRect(strokewidth: 4, strokecolor: UIColor.lightGray, fillcolor : UIColor.white)
        calculatorDisplayFrame.frame = calculatorDisplayFrameRect
        
      //  ShakeMeImageView = UIImageView()
        ShakeMeImageView.image = StyleKitCalculator.imageOfShakeMe()
        ShakeMeImageView.frame = CGRect(x: Int(twoBut.frame.origin.x)-40, y: Int(twoBut.frame.origin.y), width: 200, height: 200)
   
        
        self.initialize()
        
        
        self.addSubview(calculatorFrame)
        self.addSubview(calculatorDisplayFrame)
        
        self.addSubview(selectorNumber)
        self.addSubview(selectorOperator)
        self.addSubview(oneBut)
        self.addSubview(twoBut)
        self.addSubview(threeBut)
        self.addSubview(fourBut)
        self.addSubview(fiveBut)
        self.addSubview(sixBut)
        self.addSubview(sevenBut)
        self.addSubview(eightBut)
        self.addSubview(nineBut)
        self.addSubview(zeroBut)
        self.addSubview(commaBut)
        self.addSubview(equalBut)
        self.addSubview(plusBut)
        self.addSubview(minusBut)
        self.addSubview(multiplyBut)
        self.addSubview(divideBut)
        self.addSubview(divideBut)
        self.addSubview(resultLabel)
        
        self.addSubview(ShakeMeImageView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
