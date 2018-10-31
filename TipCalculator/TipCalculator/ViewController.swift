//
//  ViewController.swift
//  TipCalculator
//
//  Created by Bianca Campos on 2018-10-02.
//  Copyright © 2018 Bianca Campos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tipPercentage: UILabel!
    @IBOutlet weak var billAmount: UITextField!
    @IBOutlet weak var tipValue: UITextView!
    @IBAction func btnCalcTip(_ sender: Any) {
        tipValue.text = String("$\(calculateTip())") //round .rounded() .roundToPlaces(2)
    }

    @IBAction func tipPercentSlider(_ sender: UISlider) {
        tipPercentage.text = String(Int(sender.value))
    }
    var tip: Double = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billAmount.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: ViewController.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: ViewController.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
            view.addGestureRecognizer(tapGesture)
        
        
    }
    
    
    
    func calculateTip() -> Double{
        tip = (Double(billAmount.text!)! * Double(tipPercentage.text!)!) / 100
        return tip
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if view.frame.origin.y != 0{
                view.frame.origin.y += keyboardHeight
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            if view.frame.origin.y == 0{
                view.frame.origin.y -= keyboardHeight
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dismissKeyBoard(_ sender: UITapGestureRecognizer){
        billAmount.resignFirstResponder()

    }
}

