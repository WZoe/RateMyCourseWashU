//
//  MeTag.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/28/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire

class MeTag: UIViewController {
    
    var userimage:Int=cache.object(forKey: "userimage") as! Int
    var username:String=cache.object(forKey: "username")as!String
    var userid:String=cache.object(forKey: "userid")as!String
    
    let images:[UIImage]=[UIImage(named:"star")!,UIImage(named:"teacher")!]
    
    
    @IBOutlet weak var userImage: UIImageView!{
        didSet{
            userImage.image=images[userimage]
        }
    }
    
    @IBOutlet weak var userName: UILabel!{
        didSet{
            userName.text=username
        }
    }
    
    @IBOutlet weak var myProfLabel: UILabel!{
        didSet{
            var profNo:Int?
            //fetch how many professors the user likes and assigned to "profNo"
            myProfLabel.text="Professors:\(profNo ?? 0)"
        }
    }
    
    @IBOutlet weak var myMarkedCoursesLabel: UILabel!{
        didSet{
            var markedCourseNo:Int?
            //fetch how many courses the user likes and assigned to "markedCourseNo"
            myMarkedCoursesLabel.text="Marked:\(markedCourseNo ?? 0)"
        }
    }
    
    @IBOutlet weak var myTakenCoursesLabel: UILabel!{
        didSet{
            var takenCourseNo:Int?
            //fetch how many courses the user has taken and assigned to "takenCourseNo"
            myTakenCoursesLabel.text="Taken:\(takenCourseNo ?? 0)"
        }
    }
    
    @IBOutlet weak var myRatingsLabel: UILabel!{
        didSet{
            var ratingNo:Int?
            //fetch how many ratings the user has made and assigned to "ratingNo"
            myRatingsLabel.text="Ratings:\(ratingNo ?? 0)"
        }
    }
    
    @IBAction func myProfButton(_ sender: Any) {
        let detailedVC = storyboard?.instantiateViewController(withIdentifier: "MyProfessorViewController")as?MyProfessorViewController
        self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    
    
    @IBAction func myMarkedCoursesButton(_ sender: Any) {
        let detailedVC = storyboard?.instantiateViewController(withIdentifier: "MyMarkedCourseViewController")as?MyMarkedCourseViewController
        self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    
    @IBAction func myTakenCoursesButton(_ sender: Any) {
        let detailedVC = storyboard?.instantiateViewController(withIdentifier: "MyTakenCourseViewController")as?MyTakenCourseViewController
        self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    

    @IBAction func myRatingsButton(_ sender: Any) {
        let detailedVC = storyboard?.instantiateViewController(withIdentifier: "MyRatingViewController")as?MyRatingViewController
        self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    
    @IBAction func infoButton(_ sender: Any) {
        let detailedVC = storyboard?.instantiateViewController(withIdentifier: "InfoViewController")as?InfoViewController
        self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    
    
    override func viewDidLoad() {
        //userImageIndex=
        super.viewDidLoad()
        //TODO by shen,
        AF.request("http://52.170.3.234:3456/count",
                   method: .post,
                   //done by zoe: update courseID here
            parameters: ["userID":cache.object(forKey: "userid") as! String],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                let json = JSON(response.data!)
                let followCourseCount = json["followCourse"]
                let followProCount = json["followPro"]
                let ratingCourseCount = json["ratingCourse"]
                let takeCourseCount = json["takeCourseCount"]
        }
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
