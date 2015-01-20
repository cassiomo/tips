//
//  SettingsViewController.swift
//  tips
//
//  Created by Mo, Kevin on 1/19/15.
//  Copyright (c) 2015 Mo, Kevin. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate{
    func onSettingsDone(controller: SettingsViewController)
}

class SettingsViewController: UIViewController {
    
    var delegate: SettingsViewControllerDelegate?
    
    var tipPercentages: Array<Double> = [0.1, 0.2, 0.3]
    
    let defaults = NSUserDefaults.standardUserDefaults()

    @IBOutlet weak var badTipField: UITextField!
    @IBOutlet weak var goodTipField: UITextField!
    @IBOutlet weak var wellTipField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.loadFromDB()
    }
    
    func loadFromDB() {
        if let badTips: AnyObject? = defaults.objectForKey("badTips") {
            if (badTips != nil) {
                tipPercentages[0] = (badTips as Double) / 100
                println(tipPercentages[0])
                badTipField.text = String(format: "%d%%", Int(round(tipPercentages[0]  * 100)))
            }
        }
        if let goodTips: AnyObject? = defaults.objectForKey("goodTips") {
            if (goodTips != nil) {
                tipPercentages[1] = (goodTips as Double) / 100
                println(tipPercentages[1])
                goodTipField.text = String(format: "%d%%", Int(round(tipPercentages[1]  * 100)))
            }
        }
        if let wellTips: AnyObject? = defaults.objectForKey("wellTips") {
            if (wellTips != nil) {
                tipPercentages[2] = (wellTips as Double) / 100
                println(tipPercentages[2])
                wellTipField.text = String(format: "%d%%", Int(round(tipPercentages[2]  * 100)))
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSave(sender: AnyObject) {
        //var defaults = NSUserDefaults.standardUserDefaults()
        
        NSLog(badTipField.text as NSString)
        NSLog(goodTipField.text as NSString)
        NSLog(wellTipField.text as NSString)
        var badTips = (badTipField.text as NSString).doubleValue
        var goodTips = (goodTipField.text as NSString).doubleValue
        var wellTips = (wellTipField.text as
            NSString).doubleValue

        defaults.setDouble(badTips, forKey: "badTips")
        defaults.setDouble(goodTips, forKey: "goodTips")
        defaults.setDouble(wellTips, forKey: "wellTips")
        
        if delegate != nil {
            delegate!.onSettingsDone(self)
        }
    }
}
