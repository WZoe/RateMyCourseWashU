//
//  ViewController.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/9/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
// set UITextField with icon with reference to: https://medium.com/nyc-design/swift-4-add-icon-to-uitextfield-48f5ebf60aa1
extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
            CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}

class ViewController: UIViewController,UITextFieldDelegate {

    
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
            password.textContentType=UITextContentType.oneTimeCode
        }
    }
    
    @IBOutlet weak var loginMessage: UILabel!
    
    //add textFieldShouldRurn func by reference to: https://stackoverflow.com/questions/11553396/how-to-add-an-action-on-uitextfield-return-key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == password{
            textField.resignFirstResponder()
            let parameters: [String: String] = [
                "username": userName.text!,
                "password": password.text!
            ]
            AF.request("http://52.170.3.234:3456/login",
                       method: .post,
                       parameters: parameters,
                       encoder: JSONParameterEncoder.default).validate().responseJSON { response in
                        debugPrint(response)
                        var json = JSON(response.data!)
                        if json["Success"].boolValue == true {
                            self.loginMessage.text = "Log in successfully."
                            self.loginMessage.textColor=UIColor.darkGray
                            let seconds = 1.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                                let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")as?UITabBarController
                                self.show(tabBarVC!, sender: self)// Put your code which should be executed with a delay here
                            }
                            
                        }
                        else{
                            self.loginMessage.text = "Log in failed."
                            self.loginMessage.textColor=UIColor.red
                        }
            }
            return false
        }
        return true
    }
    
    @IBAction func logIn(_ sender: Any) {
        let parameters: [String: String] = [
            "username": userName.text!,
            "password": password.text!
        ]
        AF.request("http://52.170.3.234:3456/login",
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).validate().responseJSON { response in
                    debugPrint(response)
                    var json = JSON(response.data!)
                    if json["Success"].boolValue == true {
                        self.loginMessage.text = "Log in successfully."
                        self.loginMessage.textColor=UIColor.darkGray
                        let seconds = 1.0
                        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                            let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController")as?UITabBarController
                            self.show(tabBarVC!, sender: self)// Put your code which should be executed with a delay here
                        }
                        
                    }
                    else{
                        self.loginMessage.text = "Log in failed."
                        self.loginMessage.textColor=UIColor.red
                    }
        }
//        if login(userName: userName.text, password: password.text){
////            performSegue(withIdentifier: "TabBarController", sender: nil)
//
//        }

    }
    
    @IBAction func signUp(_ sender: Any) {
//        performSegue(withIdentifier: "SignUpViewController", sender: nil)
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")as?SignUpViewController
        self.show(signUpVC!, sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.password.delegate=self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.ddfdfddddhgfjhgf
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


}


