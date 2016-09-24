//
//  ViewController.swift
//  TipCalculator
//
//  Created by Colin Witkamp on 9/23/16.
//  Copyright © 2016 Colin Witkamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var tipView: UIView!
    
    @IBOutlet weak var cstTopBillField: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load default tip percent

        let settings = Settings.sharedInstance
        
        let defaultTipPercent = settings.defaultTipPercentIndex
        tipControl.selectedSegmentIndex = defaultTipPercent
        self.resultView.alpha = 0
        
        tipLabel.numberOfLines = 1
        tipLabel.adjustsFontSizeToFitWidth = true
        
        totalLabel.numberOfLines = 1
        totalLabel.adjustsFontSizeToFitWidth = true
        
        // Get locale currencySymbol
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol
        
        billField.placeholder = currencySymbol!
        
        
        tipControl.removeAllSegments()
        
        let percents = Settings.sharedInstance.tipPercents
        
        for i in 0..<percents.count {
            tipControl.insertSegment(withTitle: "\(Int(percents[i] * 100))%", at: i, animated: false)
        }
        
        let savedAmount = Settings.sharedInstance.savedBillAmount
        if savedAmount > 0 {
            if floor(savedAmount) == savedAmount {
                billField.text = "\(Int(floor(savedAmount)))"
            } else {
                billField.text = "\(savedAmount)"
            }
        }
        
        // Make bill filed first responder
        billField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tipControl.selectedSegmentIndex = Settings.sharedInstance.defaultTipPercentIndex
        
        calculateTip(self)
        
        self.tipControl.tintColor = Settings.sharedInstance.currentThemeColor
        tipView.backgroundColor = Settings.sharedInstance.currentThemeColor
        
        print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        let selectedIndex = self.tipControl.selectedSegmentIndex
        Settings.sharedInstance.defaultTipPercentIndex = selectedIndex
        
        let bill = Double(billField.text!) ?? 0
        Settings.sharedInstance.savedBillAmount = bill
        let tip = bill * Settings.sharedInstance.currentPercent
        let total = bill + tip
        
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        tipLabel.text = formatter.string(from: NSNumber(value: tip))
        totalLabel.text = formatter.string(from: NSNumber(value: total))
        
        if !billField.text!.isEmpty {
            UIView.animate(withDuration: 0.4, animations: {
                self.resultView.alpha = 1
            })
            cstTopBillField.constant = 36
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
                
            })
        }
        else {
            
            UIView.animate(withDuration: 0.4, animations: {
                self.resultView.alpha = 0
            })
            cstTopBillField.constant = 111
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
}
