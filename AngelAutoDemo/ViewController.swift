//
//  ViewController.swift
//  AngelAutoDemo
//
//  Created by Jun Mao on 8/28/15.
//  Copyright (c) 2015 Syracuse University. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKCoreKit
import ParseFacebookUtilsV4

class ViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    // Parse logIn and signUp view controller
    var logInViewController: PFLogInViewController! = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Make sure user logged out when login page loaded
        if (PFUser.currentUser() != nil) {
            PFUser.logOut()
            println("User log out.")
        }
    }
    
    // Parse default login view setting
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        if (PFUser.currentUser() == nil) {
            
            // Select what you need in your Parse login page
            self.logInViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.SignUpButton | PFLogInFields.PasswordForgotten | PFLogInFields.DismissButton
            
            // Change default Parse login logo to our custom lable
            var logInLogoTitle = UILabel()
            logInLogoTitle.text = "AngelAuto"
            self.logInViewController.logInView!.logo = logInLogoTitle
            self.logInViewController.delegate = self
            
            // Also change default Parse signup logo to our custom lable
            var SignUpLogoTitle = UILabel()
            SignUpLogoTitle.text = "AngelAuto"
            self.signUpViewController.signUpView!.logo = SignUpLogoTitle
            self.signUpViewController.delegate = self
            self.logInViewController.signUpController = self.signUpViewController
            
            }
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Parse Login
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        
        // Dismiss Parse view controller
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // Go to user page when user login with Parse successfully
        self.performSegueWithIdentifier("userpage", sender: self)
    }
    
    func logInViewController(logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        
        // Check if user input both username and password
        if (!username.isEmpty && !password.isEmpty) {
            return true
        }else {
            
            // If username or password is missing, show alert
            var alert = UIAlertView(title: "Input Missing", message: "Please input both username and password", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            return false
        }
    }

//    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
//        
//        // If fail to login, show alert
//        var alert = UIAlertView(title: "Login Fail", message: "Username or password is wrong, please try again", delegate: self, cancelButtonTitle: "OK")
//        alert.show()
//    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        println("User dismissed login.")
    }
  
    // MARK: Parse Sign Up

    func signUpViewController(signUpController: PFSignUpViewController, didSignUpUser user: PFUser) {
        
        // If sign up succeed, dismiss Parse view controller
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // When user signup successfully, they are auto logged in
        // So we take user to userpage when they signed up
        self.performSegueWithIdentifier("userpage", sender: self)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        
        // Here Parse has sigup bug, that is, you can signup only with a single username
        // So we need to avoid this bug by checking password and email input before sign up
        let dict: NSDictionary = info as NSDictionary
        let passwordValue = dict["password"] as! String
        let emailValue = dict["email"] as! String
        if (passwordValue.isEmpty || emailValue.isEmpty) {
            var alert = UIAlertView(title: "Input Missing", message: "Please input password and email", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            return false
        } else {
            return true
        }
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
        
        // Put whatever you need to do here when user fails to sign up
        println("FAiled to sign up.")
        
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController) {
        
        // Put whatever you need to do here when user cancels sign up
        println("User dismissed sign up.")
        
    }
    
    // MARK: ACTIONS
    
    // Click button to present Parse login view
    @IBAction func parseLoginAction(sender: AnyObject) {
        
        self.presentViewController(self.logInViewController, animated: true, completion: nil)
        
    }
    
    // Click button to login with facebook account
    @IBAction func facebookLoginAction(sender: AnyObject) {
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile"]) {
            (user: PFUser?, error: NSError?) -> Void in
            if let user = user {
                // If successfully login with facebook account, go to userpage
                self.performSegueWithIdentifier("userpage", sender: self)
                
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                } else {
                    println("User logged in through Facebook!")
                }
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
            }
        }
        
    }
}

