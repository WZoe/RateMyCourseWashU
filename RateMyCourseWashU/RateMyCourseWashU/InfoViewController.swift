//
//  InfoViewController.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/28/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var functionLabel: UILabel!
    override func viewDidLoad() {
        functionLabel.numberOfLines=0
        functionLabel.text="This app was developed by a group of students from 2019FL CSE438 class at WashU. We built this anonymous community for WashU students to get useful information about course registration from their peers and seniors. Hope you enjoy!"
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
