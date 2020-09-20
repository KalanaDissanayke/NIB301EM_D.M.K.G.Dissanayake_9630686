//
//  SettingsViewController.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007
//
//  Created by Kalana Dissanayake on 9/18/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var LogOutBtnRef: CustomButton!
    
    @IBOutlet weak var TblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TblView.delegate = self
        TblView.dataSource = self
        TblView.tableFooterView = UIView()
    }
    
    var settingCells = [
        "Profile",
        "Contact Us",
        "Share with Friend",
    ]
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
   
    @IBAction func CloseButtonSetting(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    
    
    @IBAction func LogOutBtn(_ sender: Any) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        tabBarController?.selectedIndex = 0
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        if Auth.auth().currentUser == nil{
            LogOutBtnRef.isHidden = true
        }
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension SettingsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        if indexPath.row == 0 {
            performSegue(withIdentifier: "Profile", sender: self)
        }
        if indexPath.row == 1 {
            performSegue(withIdentifier: "Contact Us", sender: self)
        }

    }
}


extension SettingsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        cell.textLabel?.text = settingCells[indexPath.row]
        return cell
    }
}
