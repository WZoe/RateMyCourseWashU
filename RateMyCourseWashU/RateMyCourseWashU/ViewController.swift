//
//  ViewController.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/9/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func logIn(_ sender: Any) {
        if login(userName: userName.text, password: password.text){
//            let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController")as?SignUpViewController
            self.navigationController?.pushViewController(tabBarController!, animated: true)
        }

    }
    
    @IBAction func signUp(_ sender: Any) {
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")as?SignUpViewController
        self.navigationController?.pushViewController(signUpVC!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.ddfdfddddhgfjhgf
    }


}

