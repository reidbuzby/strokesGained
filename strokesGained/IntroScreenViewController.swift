//
//  IntroScreenViewController.swift
//  strokesGained
//
//  Created by Reid Buzby on 11/20/17.
//  Copyright © 2017 Reid Buzby. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class IntroScreenViewController: UIViewController {
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        print(Auth.auth().currentUser?.uid)
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        // Do any additional setup after loading the view.
    }

    @objc func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        self.performSegue(withIdentifier: "LogoutSegue", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "eighteen" || segue.identifier == "nine" {
            let destination = segue.destination as! InputDataViewController
            
            if segue.identifier == "eighteen" {
                destination.numberOfHoles = 18
            }
            
            else if segue.identifier == "nine" {
                destination.numberOfHoles = 9
                print(destination.numberOfHoles)
            }
        }
    }
    

}
