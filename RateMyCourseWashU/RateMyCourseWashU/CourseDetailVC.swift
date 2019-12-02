//
//  CourseDetailVC.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/18/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire

class CourseDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var currentCourse: Course? = nil
    var commentList:[Rating] = []

    @IBOutlet weak var rating: UILabel!
    
    
    @IBOutlet weak var starCourse: CosmosView!
    
    @IBOutlet weak var dep: UILabel!
    @IBOutlet weak var starProf: CosmosView!
    @IBOutlet weak var myrating: UILabel!
    @IBAction func slider(_ sender: UISlider) {
        myrating.text =  String(format: "%.1f", sender.value * 10) //123.32
    }
    
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var profdepartment: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var profname: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateValue()
        setCollectionView()
        initCommentList()
        
    }
    
    func updateValue() {
        self.title = currentCourse!.title
        rating.text = String(format: "%.1f", currentCourse!.overallRating)
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
        detailvc.currentCourse = currentCourse
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
    // TODO: Add to fav
    @IBAction func add2Fav(_ sender: UIButton) {
//        showBanner(superview: view, text: "Done!")
        AF.request("http://52.170.3.234:3456/followCourse",
                   method: .post,
                   //done by zoe, 获取当前useID， 和courseID
            parameters: ["userID":cache.object(forKey: "userid") as String?, "courseID":currentCourse?.id],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                var json = JSON(response.data!)
                if json["Success"].boolValue == true {
                    //done by zoe: 弹出成功信息提示
                    showBanner(superview: self.view, type: 1)
                }
                else{
                    //failre case
                    showBanner(superview: self.view, type:2)
                }
        }
    }
    
    // TODO: mark as taken
    
    @IBAction func add2Taken(_ sender: UIButton) {
        AF.request("http://52.170.3.234:3456/takeCourse",
                   method: .post,
                   //done by zoe, 获取当前useID， 和courseID
            parameters: ["userID":cache.object(forKey: "userid") as String?, "courseID":currentCourse?.id],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                var json = JSON(response.data!)
                if json["Success"].boolValue == true {
                    //done by zoe: 弹出成功信息提示
                    showBanner(superview: self.view, type: 1)
                }
                else{
                    //failre case
                    showBanner(superview: self.view, type: 2)
                }
        }
    }
    
    // @currentUser, rating, comments, which course
    @IBAction func submitRating(_ sender: UIButton) {
        let rating  = Int((myrating.text! as NSString).doubleValue * 10)
        let parameters: [String: String] = [
            //done by zoe, 下列信息需要获取
            "userID":cache.object(forKey: "userid")! as String,
            "courseID":currentCourse!.id,
            "comment": comment.text!,
            "rating": String(rating)// 这里获取的是十进制一位小数的string，例如5.6，10.0
        ]
        
        AF.request("http://52.170.3.234:3456/submitCourseComment",
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    debugPrint(response)
                var json = JSON(response.data!)
                if json["Success"].boolValue == true {
                    //done by zoe: 弹出submit 成功信息提示
                    showBanner(superview: self.view, type: 1)
                    self.initCommentList()
                }
                else{
                    //failre case
                    showBanner(superview: self.view, type: 2)
                }
                    
        }
        
        
    }
    
    // comments collection view
    @IBOutlet weak var collectionView: UICollectionView!
    
    // TODO: fetch ratings for this course
    func initCommentList() {
        self.commentList = []
        AF.request("http://52.170.3.234:3456/getCourseCommentList",
                   method: .post,
                   //done by zoe: update courseID here
                   parameters: ["courseID":currentCourse?.id],
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    debugPrint(response)
                    let json = JSON(response.data!)
                    for (_, j):(String, JSON) in json{
                        let rating = Rating(user: User(userID: j["userID"].stringValue, username: j["userName"].stringValue, password: "why we need this", userPic: j["userPic"].intValue),
                                            rating: j["rating"].doubleValue / 10,
                                            comment: j["comment"].stringValue)
                        self.commentList.append(rating)
                    }
                    self.collectionView.reloadData()
        }
    }
    
    func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: view.frame.width, height: 75)
        }
        collectionView.register(RatingCell.self, forCellWithReuseIdentifier: "ratingCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hoc = CGFloat(75)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ratingCell", for: indexPath) as! RatingCell
        
        cell.username = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.05, width: view.frame.width*0.5, height: hoc*0.4))
        cell.username?.text = commentList[indexPath.row].user.username + ":"
        
        cell.comment = UITextView(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.45, width: view.frame.width*0.9, height: hoc*0.45))
        cell.comment?.text = commentList[indexPath.row].comment
        cell.comment?.font = UIFont.systemFont(ofSize: 16)
        cell.comment?.isEditable = false
        
        cell.rating = CosmosView(frame: CGRect(x: view.frame.width * 0.7, y: hoc*0.1, width: view.frame.width*0.35, height: hoc*0.4))
        cell.rating?.settings.fillMode = .precise
        cell.rating?.settings.updateOnTouch = false
        cell.rating?.rating = commentList[indexPath.row].rating / 2
        cell.rating?.settings.starSize = 18
        
        
        cell.addSubview(cell.username!)
        cell.addSubview(cell.comment!)
        cell.addSubview(cell.rating!)
        
        cell.layer.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        return cell as UICollectionViewCell
    }
    
}
