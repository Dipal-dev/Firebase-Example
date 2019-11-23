//
//  ViewController.swift
//  Firebase_authentication_CRUD
//
//  Created by Dipal Patel on 2019-11-21.
//  Copyright © 2019 Dipal Patel. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var statusText: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
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

    //Register User
    @IBAction func registerUser(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { authResult, error in
            guard let user = authResult?.user, error == nil else {
                self.statusText.text = error!.localizedDescription
                return
            }
            self.statusText.text = "\(user.email!) created"
        }
    }
    
   
    @IBAction func login(_ sender: Any) {
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: false, completion: nil)
        }
    }
    
}

