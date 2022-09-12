//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Déborah Suon on 20/09/2021.
//

import UIKit

class TranslateViewController: UIViewController {
    
    @IBOutlet weak var frenchTextField: UITextField!
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var translationButton: UIButton!
    
    private let service = TranslateService()
    private var language: Language = .fr
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frenchTextField.delegate = self
        englishTextView.isEditable = false
    }
    
    private func updateText(data: Translate, textView: UITextView) {
        textView.text = data.data.translations[0].translatedText
    }
    
    @IBAction func tappedTranslateButton(_ sender: Any) {
        if frenchTextField.text != "" {
            service.translate(language: language, text: frenchTextField.text!)
            { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let translatedText):
                        self.updateText(data: translatedText, textView: self.englishTextView)
                    case .failure:
                        self.presentAlert(with: "Erreur")
                    }
                }
            }
        } else {
            presentAlert(with: "Error")
        }
    }
}
    
extension TranslateViewController: UITextFieldDelegate {
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

