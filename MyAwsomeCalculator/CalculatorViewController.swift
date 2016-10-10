//
//  ViewController.swift
//  MyAwsomeCalculator
//
//  Created by Christian Andersen on 29/09/2016.
//  Copyright © 2016 Christian Andersen. All rights reserved.
//
// Version 1.0 
//
// Screen size minimum Iphone 6 
//
//
//


import UIKit

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.9
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

class CalculatorViewController: UIViewController, CalculatorKeyPressedDelegate {
    

    var myCalculator : Calculator!
    var myCalculatorView : CalculatorView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        myCalculator = Calculator()
        myCalculatorView = CalculatorView()
        myCalculatorView.frame = CGRect(x : 0, y: 0,width : self.view.frame.width,height : self.view.frame.height-100)
        myCalculatorView.delegate = self
        self.view = myCalculatorView

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UIView.animate(withDuration: 2, delay: 6, options: [ .curveEaseOut, ], animations: {
            self.myCalculatorView.ShakeMeImageView.center.x += self.view.bounds.width
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func keyPressed(Key: calculatorKeys) {
        
        let display = myCalculator.getResult(key: Key)
        if (display != "") {
            myCalculatorView.Result = display
        }
        
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (motion == UIEventSubtype.motionShake) {
            myCalculator.initialize()
            myCalculatorView.initialize()
            view.shake()
        }
    }


}

