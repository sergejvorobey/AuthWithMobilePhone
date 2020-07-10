//
//  ViewController.swift
//  AuthWithMobilePhone
//
//  Created by Sergey Vorobey on 10.07.2020.
//  Copyright © 2020 Сергей. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func authButtonPressed(_ sender: UIButton) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewController(identifier: "PhoneNumberVC") as! PhoneNumberViewController
        self.present(dvc, animated: true, completion: nil)
    }
    
    @IBAction func exitTapped(_ sender: UIStoryboardSegue) {
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DispatchQueue.main.async {
            if Auth.auth().currentUser?.uid != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let dvc = storyboard.instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
                self.present(dvc, animated: true, completion: nil)
            }
        }
    }
}

