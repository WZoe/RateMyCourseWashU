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
    
    var userimage:Int=0
    var username:String!
    var userid:String!
    var profNo:Int = 0
    var markedCourseNo:Int = 0
    var takenCourseNo:Int = 0
    var ratingNo:Int = 0
    
    let images:[UIImage]=[UIImage(named:"face0")!,UIImage(named:"face1")!,UIImage(named:"face2")!,UIImage(named:"face3")!,UIImage(named:"face4")!,UIImage(named:"face5")!,UIImage(named:"face6")!,UIImage(named:"face7")!,UIImage(named:"face8")!]
    
    @IBAction func setting(_ sender: Any) {
        let settingVC = storyboard?.instantiateViewController(withIdentifier: "SettingViewController")as?SettingViewController
        self.navigationController?.pushViewController(settingVC!, animated: true)
    }
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    //reference:https://stackoverflow.com/questions/17355280/how-to-add-a-border-just-on-the-top-side-of-a-uiview
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat, view:UIView) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: view.frame.size.height - borderWidth, width: view.frame.size.width, height: borderWidth)
        view.addSubview(border)
    }
    
    @IBOutlet weak var myProfView: UIView!{
        didSet{
            addBottomBorder(with: .lightGray, andWidth: 1.0, view: myProfView)
        }
    }
    
    @IBOutlet weak var myMarkedCourseView: UIView!{
        didSet{
            addBottomBorder(with: .lightGray, andWidth: 1.0, view: myMarkedCourseView)
        }
    }
    
    @IBOutlet weak var myTakenCourseView: UIView!{
        didSet{
            addBottomBorder(with: .lightGray, andWidth: 1.0, view: myTakenCourseView)
        }
    }
    
    @IBOutlet weak var myRatingsView: UIView!{
        didSet{
            addBottomBorder(with: .lightGray, andWidth: 1.0, view: myRatingsView)
        }
    
    }
    
    @IBOutlet weak var aboutView: UIView!{
        didSet{
            addBottomBorder(with: .lightGray, andWidth: 1.0, view: aboutView)
        }
    }
    
    @IBOutlet weak var myProfLabel: UILabel!
    
    @IBOutlet weak var myMarkedCoursesLabel: UILabel!
    
    @IBOutlet weak var myTakenCoursesLabel: UILabel!
    
    @IBOutlet weak var myRatingsLabel: UILabel!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.username=(cache.object(forKey: "username")as! NSString) as String
        self.userid=(cache.object(forKey: "userid")as! NSString) as String
        self.userName.text=self.username
        if ((cache.object(forKey: "userimage")) != nil){
            userimage=Int((cache.object(forKey: "userimage")as! NSString) as String)!
        }
        self.userImage.image=images[userimage]
        AF.request("http://52.170.3.234:3456/count",
                   method: .post,
                   //done by zoe: update courseID here
            parameters: ["userID":self.userid],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                let json = JSON(response.data!)
                let followCourseCount = json["followCourse"]
                let followProCount = json["followPro"]
                let ratingCourseCount = json["ratingCourse"]
                let takeCourseCount = json["takeCourseCount"]
                self.profNo=followProCount.intValue
                self.markedCourseNo=followCourseCount.intValue
                self.takenCourseNo=takeCourseCount.intValue
                self.ratingNo=ratingCourseCount.intValue
                self.myProfLabel.text="Professors:\(String(self.profNo))"
                print("Professors:\(String(self.profNo))")
                self.myMarkedCoursesLabel.text="Marked:\(String(self.markedCourseNo))"
                self.myTakenCoursesLabel.text="Taken:\(String(self.takenCourseNo))"
                self.myRatingsLabel.text="Ratings:\(String(self.ratingNo))"
                
                
                //                let us = cache.object(forKey: "userid")
                //userimage=cache.object(forKey: "userimage") as! Int
                
        }
    }
    
    override func viewDidLoad() {
        //userImageIndex=
        super.viewDidLoad()
        //TODO by shen,
        self.username=(cache.object(forKey: "username")as! NSString) as String
        self.userid=(cache.object(forKey: "userid")as! NSString) as String
        self.userName.text=self.username
        if ((cache.object(forKey: "userimage")) != nil){
            userimage=Int((cache.object(forKey: "userimage")as! NSString) as String)!
            }
        self.userImage.image=images[userimage]
        AF.request("http://52.170.3.234:3456/count",
                   method: .post,
                   //done by zoe: update courseID here
            parameters: ["userID":self.userid],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                let json = JSON(response.data!)
                let followCourseCount = json["followCourse"]
                let followProCount = json["followPro"]
                let ratingCourseCount = json["ratingCourse"]
                let takeCourseCount = json["takeCourseCount"]
                self.profNo=followProCount.intValue
                self.markedCourseNo=followCourseCount.intValue
                self.takenCourseNo=takeCourseCount.intValue
                self.ratingNo=ratingCourseCount.intValue
                self.myProfLabel.text="Professors:\(String(self.profNo))"
                print("Professors:\(String(self.profNo))")
                self.myMarkedCoursesLabel.text="Marked:\(String(self.markedCourseNo))"
                self.myTakenCoursesLabel.text="Taken:\(String(self.takenCourseNo))"
                self.myRatingsLabel.text="Ratings:\(String(self.ratingNo))"
                
                
                //                let us = cache.object(forKey: "userid")
                //userimage=cache.object(forKey: "userimage") as! Int
                
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
