//
//  StrokesGainedViewController.swift
//  strokesGained
//
//  Created by Reid Buzby on 11/20/17.
//  Copyright © 2017 Reid Buzby. All rights reserved.
//

import UIKit
import Firebase

class StrokesGainedViewController: UIViewController {
    
    var currentAnalyzedRound: [[Int]] = []
    var currentRoundNumber: Int = -1
    @IBOutlet weak var plusMinusLabel: UILabel!
    @IBOutlet weak var sgpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentRoundNumber)
        calculateAndSetupSGP()
        
        // Do any additional setup after loading the view.
    }
    
    func calculateAndSetupSGP() {
        let sgp = StrokesGainedManager.calculateRound(golf_round: currentAnalyzedRound)
        
        if sgp > 0 {
            plusMinusLabel.text = "+"
            sgpLabel.text = String(sgp)
            sgpLabel.textColor = UIColor.green
            plusMinusLabel.textColor = UIColor.green
        }
        else if sgp == 0 {
            plusMinusLabel.text = ""
            sgpLabel.text = String(sgp * -1)
            sgpLabel.textColor = UIColor.black
            plusMinusLabel.textColor = UIColor.black
        }
        else {
            plusMinusLabel.text = "-"
            sgpLabel.text = String(sgp * -1)
            sgpLabel.textColor = UIColor.red
            plusMinusLabel.textColor = UIColor.red
        }
        
        let ref = Database.database().reference(fromURL: "https://strokesgained-35781.firebaseio.com/")
        guard let uid = Auth.auth().currentUser?.uid else {
            print("couldnt get uid")
            return
        }
        
        ref.child("users").child(uid).child("rounds").child(String(currentRoundNumber)).updateChildValues(["sgp":sgp])
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
