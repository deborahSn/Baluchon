//
//  CurrencyViewController.swift
//  Baluchon
//
//  Created by Déborah Suon on 20/09/2021.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    @IBOutlet weak var startNameOfCurrency: UILabel!
    @IBOutlet weak var endNameOfCurrency: UILabel!
    @IBOutlet weak var startCurrencyImageView: UIImageView!
    @IBOutlet weak var endCurrencyImageView: UIImageView!
    @IBOutlet weak var startCurrencyTextField: UITextField!
    
    @IBOutlet weak var endCurrencyTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    
    @IBAction func tappedButton(_ sender: Any) {
        guard startCurrencyTextField.text != "" else {
            presentAlert(with: "error")
            return
        }
        convertCurrency()
    }
    
    private let service = CurrencyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        endCurrencyTextField.isUserInteractionEnabled = false
        startCurrencyTextField.delegate = self
    }
    
    // function to convert
    private func convertCurrency() {
        // call API to send request
        service.fetchCurrency { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let rate):
                    self.updateCurrency(data: rate)
                case .failure(_):
                    self.presentAlert(with: "Error")
                }
            }
        }
    }
    
    private func updateCurrency(data : Currency) {
        let result = self.convertWithTwoDecimals(value: self.startCurrencyTextField.text ?? "", rates: data)
        self.endCurrencyTextField.text = result
    }
    // round the result to two decimals
    private func convertWithTwoDecimals(value: String, rates: Currency) -> String  {
        guard let rate = rates.rates["USD"] else { return "erreur" }
        guard let doubleValue = Double(value) else {return "erreur"}
        return String(format:"%.2f",doubleValue / rate)
    }
    
}
// dismiss iphone keyboard
extension CurrencyViewController: UITextFieldDelegate {
    // user touches inside the view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // user presses return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

