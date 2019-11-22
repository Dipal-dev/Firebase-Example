//
//  CRUDViewController.swift
//  Firebase_authentication_CRUD
//
//  Created by Dipal Patel on 2019-11-21.
//  Copyright © 2019 Dipal Patel. All rights reserved.
//

import UIKit
import Firebase

class CRUDViewController: UIViewController {
    
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var statusText: UITextField!
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

    }

    @IBAction func addData(_ sender: UIButton) {
        
    }
    
}
