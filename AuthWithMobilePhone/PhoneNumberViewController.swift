//
//  PhoneNumberViewController.swift
//  AuthWithMobilePhone
//
//  Created by Sergey Vorobey on 10.07.2020.
//  Copyright © 2020 Сергей. All rights reserved.
//

import UIKit
import FlagPhoneNumber
import FirebaseAuth

class PhoneNumberViewController: UIViewController {
    
    var phoneNumber: String?
    var listController: FPNCountryListViewController!
    
    @IBOutlet weak var phoneNumberTfd: FPNTextField!
    @IBOutlet weak var getCodeButtonLbl: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupConfig()
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getCode(_ sender: UIButton) {
        
        guard phoneNumber != nil else {return}
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber!, uiDelegate: nil) { (verificationID, error) in
            
            if error != nil {
                print(error?.localizedDescription ?? "is empty")
            } else {
                self.showCodeValidVC(verificationID: verificationID!)
            }
        }
    }
    
    private func showCodeValidVC(verificationID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(withIdentifier: "CodeValidVC") as! CodeValidVC
        dvc.verificationID = verificationID
        self.present(dvc, animated: true, completion: nil)
    }
    
    //
    private func setupConfig() {
        getCodeButtonLbl.alpha = 0.5
        getCodeButtonLbl.isEnabled = false
        phoneNumberTfd.displayMode = .list
        phoneNumberTfd.delegate = self
        listController = FPNCountryListViewController(style: .grouped)
        listController?.setup(repository: phoneNumberTfd.countryRepository)
        listController.didSelect = { country in
            self.phoneNumberTfd.setFlag(countryCode: country.code)
        }
    }
}


extension PhoneNumberViewController: FPNTextFieldDelegate {
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        ///
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
            getCodeButtonLbl.alpha = 1
            getCodeButtonLbl.isEnabled = true
            
            phoneNumber = textField.getFormattedPhoneNumber(format: .International)
        } else {
            getCodeButtonLbl.alpha = 0.5
            getCodeButtonLbl.isEnabled = false
        }
    }
    
    func fpnDisplayCountryList() {
        let navigationController = UINavigationController(rootViewController: listController)
        listController.title = "Страны"
        phoneNumberTfd.text = ""
        self.present(navigationController, animated: true)
    }
}
