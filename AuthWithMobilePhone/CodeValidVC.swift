//
//  CodeValidVC.swift
//  AuthWithMobilePhone
//
//  Created by Sergey Vorobey on 10.07.2020.
//  Copyright © 2020 Сергей. All rights reserved.
//

import UIKit
import FirebaseAuth

class CodeValidVC: UIViewController {
    
    var verificationID: String?
    
    @IBOutlet weak var codeTxtV: UITextView!
    @IBOutlet weak var checkCodeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupConfig()
    }
    
    @IBAction func checkCodePressed(_ sender: UIButton) {
        guard let code = codeTxtV.text else { return }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID!, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (_, error) in
            if error != nil {
                let ac = UIAlertController(title: error?.localizedDescription, message: nil, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Отмена", style: .cancel)
                ac.addAction(cancel)
                self.present(ac, animated: true)
            } else {
                self.showContentVC()
            }
        }
    }
    
    private func showContentVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        self.present(dvc, animated: true, completion: nil)
    }
    
    private func setupConfig() {
        checkCodeButton.alpha = 0.5
        checkCodeButton.isEnabled = false
        codeTxtV.delegate = self
    }
}

extension CodeValidVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentCharacterCount = textView.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + text.count - range.length
        return newLength <= 6
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text?.count == 6 {
            checkCodeButton.alpha = 1
            checkCodeButton.isEnabled = true
        } else {
            checkCodeButton.alpha = 0.5
            checkCodeButton.isEnabled = false
        }
    }
}
