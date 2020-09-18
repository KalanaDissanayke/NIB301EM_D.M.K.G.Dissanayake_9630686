//
//  SettingsViewController.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007
//
//  Created by Kalana Dissanayake on 9/18/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
   
    @IBAction func CloseButtonSetting(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
