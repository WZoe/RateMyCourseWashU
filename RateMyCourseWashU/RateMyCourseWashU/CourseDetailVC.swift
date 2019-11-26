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
    
    
    @IBOutlet weak var starCourse: CosmosView!
    
    @IBOutlet weak var dep: UILabel!
    @IBOutlet weak var starProf: CosmosView!
    @IBOutlet weak var myrating: UILabel!
    @IBAction func slider(_ sender: UISlider) {
        myrating.text =  String(format: "%.1f", sender.value * 10) //123.32
    }
    @IBOutlet weak var profdepartment: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var profname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateValue()
    }
    
    func updateValue() {
        self.title = currentCourse!.title
        rating.text = String(currentCourse!.overallRating)
        starCourse.settings.fillMode = .precise
        starProf.settings.fillMode = .precise
        starCourse.rating = currentCourse!.overallRating / 2
        starProf.rating = currentCourse!.professor.rating / 2
        profname.text = currentCourse?.professor.name
        profdepartment.text = currentCourse?.professor.department
        dep.text = currentCourse?.department
        labelTitle.text = currentCourse?.title
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func jumpProfDetail(_ sender: UIButton) {
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "profdetail") as! ProfDetailVC
        detailvc.currentProf = currentCourse?.professor
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
    // TODO: jump to students list
    @IBAction func jumpStudents(_ sender: UIButton) {
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "students") as! StudentsList
//        detailvc.currentProf = currentCourse?.professor
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
    // TODO: Add to fav
    @IBAction func add2Fav(_ sender: UIButton) {
    }
    
    // TODO: mark as taken
    
    @IBAction func add2Taken(_ sender: UIButton) {
    }
    
    // TODO: submit user's rating
    // @currentUser, rating, comments, which course
    @IBAction func submitRating(_ sender: UIButton) {
    }
}
