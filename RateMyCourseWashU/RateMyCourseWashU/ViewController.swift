//
//  ViewController.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/9/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

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

class ViewController: UIViewController {

    
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
    
    @IBAction func logIn(_ sender: Any) {
        if login(userName: userName.text, password: password.text){
//            performSegue(withIdentifier: "TabBarController", sender: nil)
            let tabBarVC = storyboard?.instantiateViewController(withIdentifier: "TabBarController")as?UITabBarController
            self.show(tabBarVC!, sender: self)
        }

    }
    
    @IBAction func signUp(_ sender: Any) {
//        performSegue(withIdentifier: "SignUpViewController", sender: nil)
        let signUpVC = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")as?SignUpViewController
        self.show(signUpVC!, sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.ddfdfddddhgfjhgf
    }


}


