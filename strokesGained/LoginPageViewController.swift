//
//  LoginPageViewController.swift
//  strokesGained
//
//  Created by Reid Buzby on 11/20/17.
//  Copyright © 2017 Reid Buzby. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginPageViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginEmailField: UITextField!
    @IBOutlet weak var loginPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerUser(_ sender: Any) {

        if usernameField.text != "" && emailField.text != "" && passwordField.text != "" {
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user: User?, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                let ref = Database.database().reference(fromURL: "https://strokesgained-35781.firebaseio.com/")
                let values = ["name": self.usernameField.text!, "email": self.emailField.text!, "password": self.passwordField.text!, "numberOfRounds": "0"]
                ref.child("users").child((user?.uid)!).updateChildValues(values)
            })
        }
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        if loginEmailField.text != "" && loginPasswordField.text != "" {
            Auth.auth().signIn(withEmail: loginEmailField.text!, password: loginPasswordField.text!, completion: { (user, error) in
                
                if error != nil {
                    print(error)
                    return
                }
                
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                
            })
        }
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
