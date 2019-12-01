//
//  SettingViewController.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    var userimage:Int!
    var username=(cache.object(forKey: "username")as! NSString) as String
    
    //upload userimage to database
    @IBAction func resetPic(_ sender: Any) {
        
    }
    
    @IBAction func logout(_ sender: Any) {
        cache.removeAllObjects()
        //push back to log in scene
    
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainViewController")as?ViewController
        self.navigationController?.pushViewController(mainVC!, animated: true)
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
