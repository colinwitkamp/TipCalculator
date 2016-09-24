//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Colin Witkamp on 9/23/16.
//  Copyright © 2016 Colin Witkamp. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var themeControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tipControl.removeAllSegments()
        
        let percents = Settings.sharedInstance.tipPercents
        
        for i in 0..<percents.count {
            tipControl.insertSegment(withTitle: "\( Int(percents[i] * 100))%", at: i, animated: false)
        }
        
        themeControl.removeAllSegments()
        let themeNames = Settings.sharedInstance.themeNames;

        for i in 0..<themeNames.count {
            themeControl.insertSegment(withTitle: themeNames[i], at: i, animated: false)
        }
        
        
        
        tipControl.selectedSegmentIndex = Settings.sharedInstance.defaultTipPercentIndex
        themeControl.selectedSegmentIndex = Settings.sharedInstance.currentThemeIndex
        
        //
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tipControl.tintColor =  Settings.sharedInstance.currentThemeColor
        themeControl.tintColor =  Settings.sharedInstance.currentThemeColor
        
    }

    @IBAction func changeTipPercent(_ sender: AnyObject) {
        let selectedIndex = tipControl.selectedSegmentIndex
        
        Settings.sharedInstance.defaultTipPercentIndex = selectedIndex
    }

    @IBAction func changeTheme(_ sender: AnyObject) {
        let selectedIndex = themeControl.selectedSegmentIndex
        Settings.sharedInstance.currentThemeIndex = selectedIndex
        
        tipControl.tintColor =  Settings.sharedInstance.currentThemeColor
        themeControl.tintColor =  Settings.sharedInstance.currentThemeColor
    }
    
}
