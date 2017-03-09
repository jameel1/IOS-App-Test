//
//  ViewController.swift
//  NewLogin
//
//  Created by Jameel on 08/03/2017.
//  Copyright © 2017 Jam Inc. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class ViewController: UIViewController,GIDSignInUIDelegate {
    
    @IBOutlet weak var singinlabel: UILabel!
    @IBOutlet weak var signinselecctor: UISegmentedControl!
    @IBOutlet weak var emailfeild: UITextField!
    @IBOutlet weak var passwordfeild: UITextField!
    @IBOutlet weak var siginbutton: UIButton!

    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Google stuff
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 520, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
        googleButton.style = .wide
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//email login
    @IBAction func changer(_ sender: UISegmentedControl) {
        isSignIn = !isSignIn
        if isSignIn {
            singinlabel.text = "Log In"
            siginbutton.setTitle("Log In", for: .normal)
        }
        else{
            singinlabel.text = "Register"
            siginbutton.setTitle("Register Me", for: .normal)
        }
    }
   @IBAction func login(_ sender: UIButton) {
        if let email = emailfeild.text, let pass = passwordfeild.text
        {
    if isSignIn {
        FIRAuth.auth()?.signIn(withEmail: email, password: pass, completion: { (user, error) in
            if let u = user {
                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                print("User Logged In")
            }
            else {
                //Error MSG
                let alert = UIAlertController(title: "Account Error", message: "\(error?.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    else {
        FIRAuth.auth()?.createUser(withEmail: email, password: pass, completion: { (user, error) in
            if let u = user {
                self.performSegue(withIdentifier: "toHomeScreen", sender: self)
                print("User Account Created")
            }
            else {
               //Error MSG
                let alert = UIAlertController(title: "Account Error", message: "\(error?.localizedDescription)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
        }
           
    }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailfeild.resignFirstResponder()
        passwordfeild.resignFirstResponder()
    }
}

