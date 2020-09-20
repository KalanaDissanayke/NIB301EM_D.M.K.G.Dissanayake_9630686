//
//  UpdateViewController.swift
//  D.M.K.G.Dissanayake-COBSCCOMP191P-007
//
//  Created by Kalana Dissanayake on 9/19/20.
//  Copyright © 2020 Kalana Dissanyake. All rights reserved.
//

import UIKit
import Firebase

class UpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var lblDBname: UILabel!
    @IBOutlet weak var JoinDate: UILabel!
    @IBOutlet weak var ImpPicker: UIImageView!
    
    @IBOutlet weak var CurrTemp: UILabel!
    @IBOutlet weak var Upname: UITextField!
    @IBOutlet weak var UpAddress: UITextField!
    
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
       
       var documentId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUser()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let profileImageViewAction = UITapGestureRecognizer(target: self, action: #selector(imageUIViewAction(_:)))
        ImpPicker.isUserInteractionEnabled = true
        ImpPicker.addGestureRecognizer(profileImageViewAction)
    }
    
    func loadUser() {
        if let email = Auth.auth().currentUser?.email {
            db.collection("users").whereField("email", isEqualTo: email)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        let document = querySnapshot!.documents[0]
                        
                        self.documentId = document.documentID
                        
                        if let name = document.data()["name"] as? String, let address = document.data()["address"] as? String ,let userSince = document.data()["createdAt"] as? Timestamp, let bodyTemp = document.data()["temp"] as? String {
                            print(document.data())
                            self.navigationItem.title = name as? String
                            
                            self.lblDBname.text = name
                            self.Upname.text = name
                            self.UpAddress.text = address
                            self.JoinDate.text = "Member Since, \(userSince.dateValue().getFormattedDate(format: "dd MMM yyyy"))"
                            
                            let mf = MeasurementFormatter()
                            let temp = Measurement(value: Double(bodyTemp) ?? 0, unit: UnitTemperature.celsius)
                            mf.locale = Locale(identifier: "en_GB")
                            print(mf.string(from: temp))
                            self.CurrTemp.text = "\(mf.string(from: temp))"
                        }
                    }
            }
        }
    }
    
    @IBAction func UpdateBtn(_ sender: Any) {
        if documentId != "", let name = Upname.text, let address = UpAddress.text {
            db.collection("users").document(documentId).updateData(["name": name, "address": address]) {error in
                if let err = error {
                    print(err)
                    
                    self.lblDBname.text = ""
                    self.Upname.text = ""
                    self.UpAddress.text = ""
                    
                    return
                }
                self.lblDBname.text = name
                self.navigationItem.title = name as? String
            }
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
         @objc func imageUIViewAction(_ sender:UITapGestureRecognizer){
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                present(picker, animated: true)
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                picker.dismiss(animated: true, completion: nil)
                guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
                    return
                }
                guard let imageData = image.pngData() else {
                    return
                }
                
                if let uid = Auth.auth().currentUser?.uid {
                    
                    let ref = "images/\(uid).png"
                    
                    storage.child(ref).putData(imageData, metadata: nil, completion: { _, error in
                        if let e = error {
                            print(e)
                        }
                        self.storage.child(ref).downloadURL { (url, error) in
                        guard let url = url, error == nil else {
                            return
                        }
                        
                        let urlString = url.absoluteString
                            
                            self.db.collection("users").document(self.documentId).updateData(["profileImage": urlString])
                            
                            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                                guard let data = data, error == nil else {
                                    return
                                }
                                
                                DispatchQueue.main.async {
                                    let image = UIImage(data: data)
                                    self.ImpPicker.image = image
                                }
                            }
                            
                            task.resume()
                        }
                    })
                }
            }
        }



extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
