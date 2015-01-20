//
//  ViewController.swift
//  tips
//
//  Created by Mo, Kevin on 1/6/15.
//  Copyright (c) 2015 Mo, Kevin. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,
    SettingsViewControllerDelegate {

    @IBOutlet weak var tipControl: UISegmentedControl!

    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var billField: UITextField!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var tipPercentages: Array<Double> = [0.1, 0.2, 0.3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tipLabel.text = "$0.00"
        totalLabel.text  = "$0.00"
        
        self.loadFromDB()
    }
    
    func loadFromDB() {
        if let badTips: AnyObject? = defaults.objectForKey("badTips") {
            if (badTips != nil) {
                tipPercentages[0] = (badTips as Double) / 100
                println(tipPercentages[0])
            }
        }
        if let goodTips: AnyObject? = defaults.objectForKey("goodTips") {
            if (goodTips != nil) {
                tipPercentages[1] = (goodTips as Double) / 100
                println(tipPercentages[1])
                
            }
        }
        if let wellTips: AnyObject? = defaults.objectForKey("wellTips") {
            if (wellTips != nil) {
                tipPercentages[2] = (wellTips as Double) / 100
                println(tipPercentages[2])
            }
        }
        self.setTipControlTitles()
    }
    
    func setTipControlTitles() {
        for (index, percentage) in enumerate(tipPercentages) {
            let title = String(format: "%d%%", Int(round(percentage * 100)))
            tipControl.setTitle(title, forSegmentAtIndex: index)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        
        //var tipPercentages = [0.1, 0.2, 0.3]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        
        
        var billAmount = (billField.text as NSString).doubleValue
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format : "$%.2f", total)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let settingsViewController = segue.destinationViewController as SettingsViewController
        settingsViewController.delegate = self
        //settingsViewController.tipPercentages = tipPercentages
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func onSettingsDone(controller: SettingsViewController) {
        //tipPercentages = controller.tipPercentages
        self.loadFromDB()
        controller.navigationController?.popViewControllerAnimated(true)
    }
}

