//
//  ContentViewController.swift
//  AuthWithMobilePhone
//
//  Created by Sergey Vorobey on 10.07.2020.
//  Copyright © 2020 Сергей. All rights reserved.
//

import UIKit
import FirebaseAuth

class ContentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginOut(_ sender: UIButton!) {
         
        do {
            try Auth.auth().signOut()
           performSegue(withIdentifier: "exitTapped", sender: nil)
        } catch {
            
        }
    }
}
