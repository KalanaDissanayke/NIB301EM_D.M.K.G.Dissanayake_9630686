//
//  RegisterViewController.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007
//
//  Created by Kalana Dissanayake on 9/18/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var roleSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backToLogin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
     @IBAction func signUp(_ sender: UIButton) {
        
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {    }
    

}
