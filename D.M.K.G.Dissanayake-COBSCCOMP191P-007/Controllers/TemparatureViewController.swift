//
//  TemparatureViewController.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007
//
//  Created by Kalana Dissanayake on 9/18/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import UIKit
import Firebase

class TemparatureViewController: UIViewController {
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempTxt: UITextField!
    
    let db = Firestore.firestore()
    
    var documentId = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUser()
        
        if Auth.auth().currentUser == nil {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func TempCloseBtn(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    
    func loadUser() {
        tempLabel.text = "Fetching..."
        timeLabel.text = "Fetching..."
        
        if let email = Auth.auth().currentUser?.email {
            db.collection("users").whereField("email", isEqualTo: email)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        let document = querySnapshot!.documents[0]
                        
                        self.documentId = document.documentID
                        
                        if let temp = document.data()["temp"], let lastModified = document.data()["lastModified"] {
//                            self.tempLabel.text = "\(temp as? String) C"
                            if let timestamp = lastModified as? Timestamp, let tempC = temp as? String {
                                self.timeLabel.text = "\(timestamp.dateValue())"
                                self.tempLabel.text = "\(tempC) C"
                            }
                        } else {
                            self.tempLabel.text = "Not Updated"
                            self.timeLabel.text = "Not Updated"
                        }
//                        for document in querySnapshot!.documents {
//                            print("\(document.documentID) => \(document.data())")
//                        }
                    }
            }
        }
    }
    
    
     @IBAction func updateTemp(_ sender: Any) {
        if documentId != "", let temp = tempTxt.text {
            db.collection("users").document(documentId).updateData(["temp": temp, "lastModified": Date()]) {error in
                if let err = error {
                    print(err)
                    return
                }
                self.tempLabel.text = "\(temp) C"
                self.timeLabel.text = "\(Date())"
                self.tempTxt.text = ""
            }
        }
     }
     

}
