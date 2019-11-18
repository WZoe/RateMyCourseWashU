//
//  SignUpViewController.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

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
        }
    }
    
    @IBOutlet weak var confirmPassword: UITextField!{
        didSet {
            confirmPassword.tintColor = UIColor.darkGray
            confirmPassword.setIcon(UIImage(imageLiteralResourceName:"password"))
        }
    }
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func signUp(_ sender: Any) {
        if password.text==confirmPassword.text{
            let message=signup(userName: userName.text, password: password.text)
            if message=="Sign up successfully"{
                messageLabel.text=message
                messageLabel.textColor=UIColor.darkGray
                // need to add a delay to show message
                let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainViewController")as?ViewController
                self.show(mainVC!, sender: self)
            }
            else{
                messageLabel.text=message
                messageLabel.textColor=UIColor.red
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

