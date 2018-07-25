//
//  UserProfileViewController.swift
//  AirIndia
//
//  Created by Cheeja on 6/12/18.
//  Copyright © 2018 RJTCompuquest. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import TWMessageBarManager
import SVProgressHUD
import SDWebImage

class UserProfileViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var databaseRef: DatabaseReference?
    var storageRef: StorageReference?
    var curUser = Auth.auth().currentUser?.uid
     var userArr : Array<User> = []
    @IBOutlet weak var imgViewEditProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imgViewEditProfile.layer.cornerRadius = imgViewEditProfile.frame.size.height/2
        imgViewEditProfile.layer.borderColor = UIColor.black.cgColor
        imgViewEditProfile.layer.borderWidth = 1.0
       
        FirebaseHandler.sharedInstance.getSingleUser(userID: curUser!) { (user) in
            let url = URL(string: user.UserImage!)
            self.imgViewEditProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "UserDefault"))
        }
        databaseRef = Database.database().reference().child("Users")
    }
    
    @IBAction func btnChangeProfile(_ sender: Any) {
        imagePicker.allowsEditing = true
        if imagePicker.sourceType == .camera {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.imgViewEditProfile.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDone(_ sender: Any) {
        SVProgressHUD.show()
        storageRef = Storage.storage().reference()
        if let curUser = Auth.auth().currentUser {
            let userImage = self.imgViewEditProfile.image
            if userImage != nil {
                let data = UIImagePNGRepresentation(userImage!)
                let metadata = StorageMetadata()
                metadata.contentType = "image/png"
                let imageName = "UserImage/\(String(describing: curUser.uid)).png"
                storageRef = storageRef?.child(imageName)
                
                storageRef?.putData(data!, metadata: metadata, completion: { (meta, error) in
                    if let err = error {
                        TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type: .error)
                        SVProgressHUD.dismiss()
                    } else {
                        self.storageRef?.downloadURL(completion: { (url, error) in
                            if error == nil {
                                let urlStr = url?.absoluteString
                                let userDict = ["UserImage": urlStr]
                                self.databaseRef?.child(curUser.uid).updateChildValues(userDict, withCompletionBlock: { (error, ref) in
                                    if let err = error {
                                        TWMessageBarManager().showMessage(withTitle: "Error", description: err.localizedDescription, type: .error)
                                        SVProgressHUD.dismiss()
                                        //self.navigationController?.popViewController(animated: true)
                                    } else {
                                        TWMessageBarManager().showMessage(withTitle: "Success", description: "Uploaded", type: .success)
                                        SVProgressHUD.dismiss()
                                        //self.navigationController?.popViewController(animated: true)
                                    }
                                })
                            }
                        })
                    }
                })
            } else {
                TWMessageBarManager().showMessage(withTitle: "Error", description: "Please select an image", type: .error)
                //self.navigationController?.popViewController(animated: true)
                SVProgressHUD.dismiss()
            }
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
