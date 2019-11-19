//
//  CourseDetailVC.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/18/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class CourseDetailVC: UIViewController {
    
    var currentCourse: Course? = nil

    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var ratingbar: UIProgressView!
    

    @IBOutlet weak var myrating: UILabel!
    @IBAction func slider(_ sender: UISlider) {
        myrating.text =  String(format: "%.1f", sender.value * 10) //123.32
    }
    @IBOutlet weak var profratingbar: UIProgressView!
    @IBOutlet weak var profdepartment: UILabel!
    @IBOutlet weak var profname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateValue()
    }
    
    func updateValue() {
        self.title = currentCourse!.title
        rating.text = String(currentCourse!.overallRating)
        ratingbar.progress = Float(currentCourse!.overallRating)
        profname.text = currentCourse?.professor.name
        profratingbar.progress = Float(currentCourse!.professor.rating)
        profdepartment.text = currentCourse?.professor.department
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
