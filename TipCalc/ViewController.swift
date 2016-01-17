//
//  ViewController.swift
//  TipCalc
//
//  Created by Anupam on 1/13/16.
//  Copyright © 2016 Anupam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtBillAmount: UITextField!
    
    @IBOutlet weak var labelTip: UILabel!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var segTipPercentage: UISegmentedControl!
    @IBOutlet weak var viewTipView: UIView!
    @IBOutlet weak var labelUserPrompt: UILabel!
    @IBOutlet weak var sliderTip: UISlider!
    @IBOutlet weak var labelSliderTipValue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Reset values on first load
        txtBillAmount.text = "0"
        labelTip.text = "$0.00"
        labelTotal.text = "$0.00"
        viewTipView.hidden = true
        txtBillAmount.becomeFirstResponder()
        
        //Hide slider view for tips since segmented COntrol is default selector
        sliderTip.hidden = true
        labelSliderTipValue.hidden = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onAmountEditingChanged(sender: AnyObject) {
        //hide the user prompt to enter bill amount
        labelUserPrompt.hidden = true
        
        var tipPercentage = 0.00
        let tipPercentages = [ 0.15, 0.2, 0.25]
        
        //Grab tip Percentage from slider or seg based on which one is currently visible to user
        if sliderTip.hidden == false {
            //Remove decimals from slider value of tip percentage by casting to Int
            tipPercentage = Double(Int(sliderTip.value))
            //remove trailing .00 from tip percentage to make better use of real eastate
            labelSliderTipValue.text = String(format: "%.0f%%", tipPercentage)
            tipPercentage = tipPercentage / 100
        } else {
            tipPercentage = tipPercentages[segTipPercentage.selectedSegmentIndex]
        }
        
        var billAmount =  Double(txtBillAmount.text!)
        //handle invalid scenerio
        if billAmount == nil {
            billAmount = 0.0
        }
        
        let tip = billAmount! * tipPercentage
        let total = billAmount! + tip
        labelTip.text = String(format: "$%.2f", tip)
        labelTotal.text = String(format: "$%.2f", total)
        viewTipView.hidden = false
   
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func resetAmount(sender: AnyObject) {
        txtBillAmount.text = ""
    }
    @IBAction func changeTipInput(sender: AnyObject) {
        if sliderTip.hidden == true {
            sliderTip.hidden = false
            labelSliderTipValue.hidden = false
            segTipPercentage.hidden = true
        } else {
            sliderTip.hidden = true
            labelSliderTipValue.hidden = true
            segTipPercentage.hidden = false

        }
        //Refresh Tip & total based on current selection
        onAmountEditingChanged(sender)
    }

}

