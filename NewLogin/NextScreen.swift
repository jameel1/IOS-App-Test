//
//  NextScreen.swift
//  NewLogin
//
//  Created by Jameel on 08/03/2017.
//  Copyright © 2017 Jam Inc. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class NextScreen: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //Email and Password pull
        let userID = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            if let savedData = snapshot.value as? [String: AnyObject]{
            self.nameLabel.text = savedData["Name"] as? String
            self.emailLabel.text = savedData["Email"] as? String
            print(snapshot)
            }
        })
        /*GoogleData
        let profileURL = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 125)
        print(profileURL)
        profileImage.image = UIImage(data: NSData(contentsOf: profileURL!)! as Data)*/
    }

    //BAR STYLE
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    @IBAction func logout(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
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
