//
//  LoginViewController.swift
//  weatherApp_API
//
//  Created by user182271 on 12/9/20.
//

import UIKit
import FirebaseUI
class LoginViewController: UIViewController, FUIAuthDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let authUI = FUIAuth.defaultAuthUI(){
            authUI.providers = [FUIOAuth.appleAuthProvider(), FUIOAuth.twitterAuthProvider()]
            authUI.delegate = self
            let authViewController = authUI.authViewController()
            let textField = UITextView(frame: CGRect(x: 10.0, y: 350.0, width: UIScreen.main.bounds.size.width - 20.0, height: 50.0))
            textField.textAlignment = .center
            textField.text = "Social Media Login Disabled.\n\nBypass login by touching \"Cancel\" and then touching \"Weather\".\n"
            authViewController.view.addSubview(textField)
            
            self.present(authViewController, animated: true)
        }
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let user = authDataResult?.user{
            print("Nice! You have signed in as \(user.uid). Your email is: \(user.email)")
        }
        print("This is the error: " + "\(error)")
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
