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
    @IBOutlet weak var showData: UITextView!
    
    var ref: DatabaseReference!
    var displayData: String! = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        ref.child("users").observe(.value, with: { snapshot in
            self.displayData = ""
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot {
                    print(snapshot)
                    if let value = snapshot.value as? [String: Any] {
                        let name = value["name"] as? String ?? ""
                        let age = value["age"] as? String ?? ""
                        self.displayData = self.displayData+"Name : "+name+" Age : "+age+"\n"
                    }
                }
            }
            self.showData.text = self.displayData
        })

    }

    @IBAction func createData(_ sender: UIButton) {
        //guard let userID = Auth.auth().currentUser?.uid else { return }
        
        guard let keyValue = self.ref.child("users").childByAutoId().key else { return }
        let userItemRef = self.ref.child("users").child(keyValue)
        userItemRef.setValue(["name": nameText.text,"age":ageText.text])
        
        ref.child("users").observe(.value, with: { snapshot in
            self.displayData = ""
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot {
                    print(snapshot)
                    if let value = snapshot.value as? [String: Any] {
                        let name = value["name"] as? String ?? ""
                        let age = value["age"] as? String ?? ""
                        self.displayData = self.displayData+"Name : "+name+" Age : "+age+"\n"
                    }
                }
            }
            self.showData.text = self.displayData
        })

    }
    
    @IBAction func updateData(_ sender: Any) {
        
      /*  ref.child("users").updateChildValues([
            "age": "26"
            ])*/
        
        
        // create the reference you want to observe
        let myRequestRef = ref.child("users").queryOrdered(byChild: "name").queryEqual(toValue: nameText.text)
        
        // check the sender value
        myRequestRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                
                if let item = child as? DataSnapshot {
                    
                    item.ref.setValue(24, forKey: "age");
                }
            }
    })
}
    
    
    @IBAction func deleteData(_ sender: Any) {
        ref.child("users").removeValue()
    }
    
    
    @IBAction func logout(_ sender: Any) {
        try! Auth.auth().signOut()
        
        if let storyboard = self.storyboard {
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    
}
