//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by VJ's iMAC on 22/06/20.
//  Copyright © 2020 Deuglo. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController,GIDSignInDelegate {
    @IBOutlet weak var textField: UITextField!
    fileprivate let pickerView = ToolbarPickerView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
    }
    
    @IBAction func googleLoggedIn() {
        
        GIDSignIn.sharedInstance()?.signIn()
        

    }


}

extension ViewController {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let _ = user.userID                  // For client-side use only!
        let _ = user.authentication.idToken // Safes to send to the server
        _ = user.profile.name
        _ = user.profile.givenName
        let _ = user.profile.familyName
        _ = user.profile.email
        
        if error == nil {
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "BaseCurrencyViewController") as! BaseCurrencyViewController
            self.present(secondViewController, animated: true, completion: nil)
            
        } else {
            
        }
        
      
    }
}
