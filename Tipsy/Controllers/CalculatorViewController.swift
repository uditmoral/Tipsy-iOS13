//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tipSelected = 10.0
    var currentValue:Double = 2.0
    var billAmount = 0.0
    var finalResult = "0.0"
  

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        if sender.currentTitle == "0%" {
            zeroPctButton.isSelected = true
            tipSelected = 0.0
        }else if sender.currentTitle == "10%"{
            tenPctButton.isSelected = true
            tipSelected = 10.0
        }else {
            twentyPctButton.isSelected = true
            tipSelected = 20.0
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        currentValue = sender.value
        
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != ""{
            billAmount = Double(bill)!
            let result = (billAmount + ((billAmount * tipSelected)/100))/currentValue
            finalResult = String(format: "%.2f", result)
            
        }
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = finalResult
            destinationVC.numberOfPerson = Int(currentValue)
            destinationVC.tip = tipSelected
        }
    }
}

