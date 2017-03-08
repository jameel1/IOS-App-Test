//
//  NextScreen.swift
//  NewLogin
//
//  Created by Jameel on 08/03/2017.
//  Copyright © 2017 Jam Inc. All rights reserved.
//

import UIKit
import Firebase

class NextScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logout(_ sender: UIButton) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
            print("User Logged Out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            
        }
        self.performSegue(withIdentifier: "backtologinscreen", sender: self)
        
        
    }

   

}
