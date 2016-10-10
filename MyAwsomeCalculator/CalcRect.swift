//
//  CalcRect.swift
//  MyAwsomeCalculator
//
//  Created by Christian Andersen on 08/10/2016.
//  Copyright © 2016 Christian Andersen. All rights reserved.
//

import Foundation

class CalculatorRect : UIView
{
    
    
    private var _strokecolor : UIColor?
    private var _strokewidth : Float?
    private var oldwidth : Float?
    
    init (strokewidth : Float, strokecolor : UIColor? = nil, fillcolor : UIColor? = nil)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        if (strokecolor == nil) {
            _strokecolor = UIColor.black
        }
        else {
            _strokecolor = strokecolor!
        }
        oldwidth = strokewidth
        _strokewidth = oldwidth
        if (fillcolor == nil) {
            backgroundColor = UIColor.clear
        }
        else {
            backgroundColor = fillcolor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func Show()
    {
        self._strokewidth = oldwidth;
        self.frame = CGRect(x: self.frame.origin.x-3, y: self.frame.origin.y-3,  width : self.frame.width+6, height : self.frame.height+3)
        self.setNeedsDisplay()
    }
    
    func Hide()
    {
        self._strokewidth = 0;
        self.setNeedsDisplay()
    }
    
    
    override func draw(_ rect : CoreGraphics.CGRect)
    {
        super.draw(rect)
        let g = UIGraphicsGetCurrentContext()
        g?.setLineWidth(CGFloat(_strokewidth!))
        g?.setStrokeColor((_strokecolor?.cgColor)!)
        g?.stroke(rect)  //this will draw the border
    }
}
