//
//  SignUpViewController.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBAction func signUp(_ sender: Any) {
        let message=signup(userName: userName.text, password: password.text)
        print(message)
        if message=="Sign up successfully"{
            let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainViewController")as?ViewController
            self.navigationController?.pushViewController(mainVC!, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
