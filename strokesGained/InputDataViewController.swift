//
//  InputDataViewController.swift
//  strokesGained
//
//  Created by Reid Buzby on 11/20/17.
//  Copyright © 2017 Reid Buzby. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class InputDataViewController: UIViewController {
    
    var numberOfHoles = 0
    var currentHole = 1
    var newRoundNumber = -1
    
    @IBOutlet weak var holeNumberText: UILabel!
    @IBOutlet weak var puttOneField: UITextField!
    @IBOutlet weak var puttTwoField: UITextField!
    @IBOutlet weak var puttThreeField: UITextField!
    @IBOutlet weak var puttFourField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
        
    var currentRound:[[Int]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isHidden = false
        submitButton.isHidden = true
        
        let ref = Database.database().reference(fromURL: "https://strokesgained-35781.firebaseio.com/")
        
        currentHole = 1
    }
    
    @IBAction func nextHole(_ sender: Any) {
        
        var puttOne:Int?
        var puttTwo:Int?
        var puttThree:Int?
        var puttFour:Int?
        
        holeNumberText.text = "Hole " + String(currentHole)
        
        if currentHole + 1 != numberOfHoles {
            if puttOneField.text != "" {
                puttOne = Int(puttOneField.text!)!
            }
            else {
                puttOne = nil
            }
        
            if puttTwoField.text != "" {
                puttTwo = Int(puttTwoField.text!)!
            }
            else {
                puttTwo = nil
            }
        
            if puttThreeField.text != "" {
                puttThree = Int(puttThreeField.text!)!
            }
            else {
                puttThree = nil
            }
        
            if puttFourField.text != "" {
                puttFour = Int(puttFourField.text!)!
            }
            else {
                puttFour = nil
            }
        
            var holeData:[Int] = []
        
            if puttOne != nil {
                holeData.append(puttOne!)
            }
            if puttTwo != nil {
                holeData.append(puttTwo!)
            }
            if puttThree != nil {
                holeData.append(puttThree!)
            }
            if puttFour != nil {
                holeData.append(puttFour!)
            }
            
            currentRound.append(holeData)
            currentHole += 1
            holeNumberText.text = "Hole " + String(currentHole)
            
            puttOneField.text = ""
            puttTwoField.text = ""
            puttThreeField.text = ""
            puttFourField.text = ""
        }
        else {
            if puttOneField.text != "" {
                puttOne = Int(puttOneField.text!)!
            }
            else {
                puttOne = nil
            }
            
            if puttTwoField.text != "" {
                puttTwo = Int(puttTwoField.text!)!
            }
            else {
                puttTwo = nil
            }
            
            if puttThreeField.text != "" {
                puttThree = Int(puttThreeField.text!)!
            }
            else {
                puttThree = nil
            }
            
            if puttFourField.text != "" {
                puttFour = Int(puttFourField.text!)!
            }
            else {
                puttFour = nil
            }
            
            var holeData:[Int] = []
            
            if puttOne != nil {
                holeData.append(puttOne!)
            }
            if puttTwo != nil {
                holeData.append(puttTwo!)
            }
            if puttThree != nil {
                holeData.append(puttThree!)
            }
            if puttFour != nil {
                holeData.append(puttFour!)
            }
            
            currentRound.append(holeData)
            
            currentHole += 1
            holeNumberText.text = "Hole " + String(currentHole)
            nextButton.isHidden = true
            submitButton.isHidden = false
            
            puttOneField.text = ""
            puttTwoField.text = ""
            puttThreeField.text = ""
            puttFourField.text = ""
        }
        
    }
    
    @IBAction func submitRound(_ sender: Any) {
        var puttOne:Int?
        var puttTwo:Int?
        var puttThree:Int?
        var puttFour:Int?
        
        if puttOneField.text != "" {
            puttOne = Int(puttOneField.text!)!
        }
        else {
            puttOne = nil
        }
        
        if puttTwoField.text != "" {
            puttTwo = Int(puttTwoField.text!)!
        }
        else {
            puttTwo = nil
        }
        
        if puttThreeField.text != "" {
            puttThree = Int(puttThreeField.text!)!
        }
        else {
            puttThree = nil
        }
        
        if puttFourField.text != "" {
            puttFour = Int(puttFourField.text!)!
        }
        else {
            puttFour = nil
        }
        
        var holeData:[Int] = []
        
        if puttOne != nil {
            holeData.append(puttOne!)
        }
        if puttTwo != nil {
            holeData.append(puttTwo!)
        }
        if puttThree != nil {
            holeData.append(puttThree!)
        }
        if puttFour != nil {
            holeData.append(puttFour!)
        }
        
        currentRound.append(holeData)
        let ref = Database.database().reference(fromURL: "https://strokesgained-35781.firebaseio.com/")
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("couldnt get uid")
            return
        }

        ref.child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let numberOfRounds = String(describing: snapshot.childSnapshot(forPath: "numberOfRounds").value!)
            let nsRounds = self.currentRound as NSArray
            
            ref.child("users").child(uid).child("rounds").updateChildValues([numberOfRounds:nsRounds])
            let numberOfRoundsInt:Int = Int(numberOfRounds)! + 1
            ref.child("users").child(uid).updateChildValues(["numberOfRounds":String(numberOfRoundsInt)])
            self.newRoundNumber = numberOfRoundsInt - 1
            print(self.newRoundNumber)
        }
        
        perform(#selector(submit), with: nil, afterDelay: 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func submit() {
        self.performSegue(withIdentifier: "SubmitRound", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SubmitRound" {
            let destination = segue.destination as! StrokesGainedViewController
            destination.currentAnalyzedRound = self.currentRound
            destination.currentRoundNumber = self.newRoundNumber
            print(destination.currentRoundNumber)
        }
        
        
        
    }
    

}
