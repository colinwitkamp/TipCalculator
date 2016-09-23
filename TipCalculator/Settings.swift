//
//  Settings.swift
//  TipCalculator
//
//  Created by Colin Witkamp on 9/23/16.
//  Copyright © 2016 Colin Witkamp. All rights reserved.
//

import Foundation
import UIKit
class Settings {
    static var sharedInstance = Settings()
    
    private let defaultTipPercentIndexKey = "DefaultTipPercentKey"
    private let defaultThemeKey = "DefaultThemeKey"
    private let defaultRememberRateKey = "DefaultRememberRateKey"
    private let defaultSavedBillAmountKey = "DefaultSavedBillAmountKey"
    
    public var tipPercents:[Double] = [0.10, 0.15, 0.20]
    
    private let rememberRateLimit:Double = 10 * 60 // 10 mins
    
    public let themeColors: [UIColor] = [UIColor(red: 10 / 255.0, green: 131 / 255.0, blue: 0, alpha: 1), UIColor(red: 65 / 255.0, green: 186 / 255.0, blue: 47 / 255.0, alpha: 1)]
    public let themeNames = ["Dark", "Light"]
    
    public var defaultTipPercentIndex:Int {
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: self.defaultTipPercentIndexKey)
            defaults.synchronize()
        }
        get {
            let defaults = UserDefaults.standard
            let index = defaults.integer(forKey: self.defaultTipPercentIndexKey)
            if index < self.tipPercents.count && index >= 0 {
                return index
            } else {
                print ("Invlaid defaultTipPercentIndex! Default value returned!")
                return 0
            }
        }
    }
    
    public var currentPercent: Double {
        get {
            return self.tipPercents[self.defaultTipPercentIndex]
        }
    }
    
    public var currentThemeIndex: Int{
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: self.defaultThemeKey)
            defaults.synchronize()
        }
        get {
            let defaults = UserDefaults.standard
            let index = defaults.integer(forKey: self.defaultThemeKey)
            if index < self.themeColors.count && index >= 0 {
                return index
            } else {
                print ("Invlaid defaultThemeIndex! Default value returned!")
                return 0
            }
        }
    }
    
    public var currentThemeColor: UIColor {
        get {
            return themeColors[currentThemeIndex]
        }
    }
    
    public var savedDate:NSDate {
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue.timeIntervalSince1970, forKey: self.defaultRememberRateKey)
            defaults.synchronize()
        }
        get {
            let defaults = UserDefaults.standard
            let interval = defaults.double(forKey: self.defaultRememberRateKey)
            return NSDate(timeIntervalSince1970: interval)
        }
    }
    
    public var savedBillAmount:Double {
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: self.defaultSavedBillAmountKey)
            self.savedDate = NSDate()
            defaults.synchronize()
        }
        get {
            let defaults = UserDefaults.standard
            let amount = defaults.double(forKey: self.defaultSavedBillAmountKey)
            return amount
        }
    }
    
    init() {

        if -self.savedDate.timeIntervalSinceNow > self.rememberRateLimit {
            self.savedBillAmount = 0
        }
        self.savedDate = NSDate()
    }
}
