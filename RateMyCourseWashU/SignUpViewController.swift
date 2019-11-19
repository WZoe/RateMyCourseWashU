//
//  SignUpViewController.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class SignUpViewController: UIViewController,UINavigationBarDelegate {
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
            password.isSecureTextEntry=true
        }
    }
    
    @IBOutlet weak var confirmPassword: UITextField!{
        didSet {
            confirmPassword.tintColor = UIColor.darkGray
            confirmPassword.setIcon(UIImage(imageLiteralResourceName:"password"))
            confirmPassword.isSecureTextEntry=true
        }
    }
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func signUp(_ sender: Any) {
        if password.text==confirmPassword.text{
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
                            self.messageLabel.text = "Please try another userName"
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
        navBar.delegate=self
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

