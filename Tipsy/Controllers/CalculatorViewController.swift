//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipValue : Float?
    var total : Float?
    var tipPerPerson: Float?
    var tipSelected: String?
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        tipSelected = sender.currentTitle
        if let safeTipSelected = tipSelected {
            if safeTipSelected == "0%" {
                tipValue = 0.0
            } else if safeTipSelected == "10%" {
                tipValue = 0.1
            } else {
                tipValue = 0.2
            }
            
            zeroPctButton.isSelected = false
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
            sender.isSelected = true
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%0.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        if let billText = billTextField.text, let billValue = Float(billText) {
            // If we successfully get a valid bill value from the text field
            total = billValue + (billValue * (tipValue ?? 0.0))
        } else {
            // If the text field is empty or doesn't contain a valid number
            // You may want to handle this case, for example, setting total to zero
            total = 0.0
        }
        let splitNumber = Float(splitNumberLabel.text!)!
        tipPerPerson = total! / splitNumber
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalPerPerson = String(format: "%0.2f", tipPerPerson ?? 0.0)
            destinationVC.splitDetails = "Split between \(splitNumberLabel.text!) people, with \(tipSelected!) tip."
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

