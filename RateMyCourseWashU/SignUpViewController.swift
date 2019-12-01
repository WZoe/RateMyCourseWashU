//
//  SignUpViewController.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire
import PusherChatkit
import Foundation

class SignUpViewController: UIViewController,UINavigationBarDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var userName: UITextField!{
        didSet {
            userName.tintColor = UIColor.darkGray
            userName.setIcon(UIImage(imageLiteralResourceName:"user"))
        }
    }
    @IBOutlet weak var password: UITextField!{
        didSet {
            password.tintColor = UIColor.darkGray
            password.setIcon(UIImage(imageLiteralResourceName:"password"))
            password.isSecureTextEntry=false
            password.textContentType=UITextContentType.oneTimeCode
        }
    }
    
    @IBOutlet weak var confirmPassword: UITextField!{
        didSet {
            confirmPassword.tintColor = UIColor.darkGray
            confirmPassword.setIcon(UIImage(imageLiteralResourceName:"password"))
            confirmPassword.isSecureTextEntry=false
            confirmPassword.textContentType=UITextContentType.oneTimeCode
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == password{
            textField.resignFirstResponder()
            if userName.text!.isEmpty{
                self.messageLabel.text="Please enter username"
                self.messageLabel.textColor=UIColor.red
            }
            else if password.text!.isEmpty{
                self.messageLabel.text="Please enter password"
                self.messageLabel.textColor=UIColor.red
            }
            else if confirmPassword.text!.isEmpty{
                self.messageLabel.text="Please confirm password"
                self.messageLabel.textColor=UIColor.red
            }
            else if password.text==confirmPassword.text{
                let parameters: [String: String] = [
                    "user": userName.text!,
                    "password": password.text!
                ]
                AF.request("http://52.170.3.234:3456/signup",
                           method: .post,
                           parameters: parameters,
                           encoder: JSONParameterEncoder.default).validate().responseJSON { response in
                            debugPrint(response)
                            var json = JSON(response.data!)
                            if json["Success"].boolValue == true {
                                self.messageLabel.text = "Sign up successfully"
                                self.messageLabel.textColor=UIColor.darkGray
                                let seconds = 1.0
                                DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                    let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainViewController")as?ViewController
                                    self.show(mainVC!, sender: self)// Put your code which should be executed with a delay here
                                }
                                
                            }else if json["Message"].intValue == 1 {
                                self.messageLabel.text = "Please try another username"
                                self.messageLabel.textColor=UIColor.red
                            }
                }
            }
            else{
                messageLabel.text="Two input passwords are inconsistent"
                messageLabel.textColor=UIColor.red
            }
            return false
        }
        return true
    }
    
    @IBAction func signUp(_ sender: Any) {
        if userName.text!.isEmpty{
            self.messageLabel.text="Please enter username"
            self.messageLabel.textColor=UIColor.red
        }
        else if password.text!.isEmpty{
            self.messageLabel.text="Please enter password"
            self.messageLabel.textColor=UIColor.red
        }
        else if confirmPassword.text!.isEmpty{
            self.messageLabel.text="Please confirm password"
            self.messageLabel.textColor=UIColor.red
        }
        else if password.text==confirmPassword.text{
            let parameters: [String: String] = [
                "user": userName.text!,
                "password": password.text!
            ]
            AF.request("http://52.170.3.234:3456/signup",
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default).validate().responseJSON { response in
                        debugPrint(response)
                        var json = JSON(response.data!)
                        if json["Success"].boolValue == true {
                            let userId = json["userID"].stringValue
                            
                            // create user in pusher
                            let url = URL(string: "\(ep)/users")
                            var token = ""
                            
//                            // TODO： get token
//                            AF.request("https://us1.pusherplatform.io/services/chatkit_token_provider/v1/42106c7e-a9e7-4375-b4cc-77e586b4bd58/token",
//                                       method: .post,
//                                       parameters: ["grant_type":"client_credentials", "user_id":"admin"],
//                                       encoder: JSONParameterEncoder.default).responseJSON { response in
//                                        let json = JSON(response.data!)
//                                        token = json["access_token"].stringValue
//
//                                        // create user
//                                        // TODO: avatar_url
//                                        AF.request(url!, method: .post, parameters: ["id": userId, "name": parameters["username"] ,"avatar_url" : "https://image.flaticon.com/icons/svg/597/597228.svg"], headers: ["authorization":"Bearer \(token)"]).responseJSON { response in
//                                            debugPrint(response)
//                                        }
//                            }

                            
                            self.messageLabel.text = "Sign up successfully"
                            self.messageLabel.textColor=UIColor.darkGray
                            let seconds = 1.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainViewController")as?ViewController
                                self.show(mainVC!, sender: self)// Put your code which should be executed with a delay here
                            }
                            
                        }else if json["Message"].intValue == 1 {
                            self.messageLabel.text = "Please try another username"
                            self.messageLabel.textColor=UIColor.red
                        }
            }
        }
        else{
            messageLabel.text="Two input passwords are inconsistent"
            messageLabel.textColor=UIColor.red
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.confirmPassword.delegate=self
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        // Do any additional setup after loading the view.
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
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

