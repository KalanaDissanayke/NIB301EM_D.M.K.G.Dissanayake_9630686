//
//  SignInViewController.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007
//
//  Created by Kalana Dissanayake on 9/18/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    
    @IBOutlet weak var signinText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func signinButton(_ sender: Any) {
        let email = signinText.text!
        let password = passwordText.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let err = error {
                        print(err)
                        return
                    }
                    
            self.performSegue(withIdentifier: "singInToTemp", sender: self)
        }
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
