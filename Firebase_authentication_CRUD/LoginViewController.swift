//
//  LoginViewController.swift
//  Firebase_authentication_CRUD
//
//  Created by Dipal Patel on 2019-11-21.
//  Copyright © 2019 Dipal Patel. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var statusText: UITextField!
    
     var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    //Login User
    @IBAction func loginUser(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { [weak self] authResult, error in
            //guard let strongSelf = self else { return }
            if let error = error {
                self!.statusText.text = error.localizedDescription
                return
            } else {
                self!.statusText.text = "Login Successful"
            }
        }
    }

}
