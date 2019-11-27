//
//  CourseDetailVC.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/18/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

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
        detailvc.currentCourse = currentCourse
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
    
    // comments collection view
    @IBOutlet weak var collectionView: UICollectionView!
    
    // TODO: fetch ratings for this course
    func initCommentList() {
        let user = User(userID: "1111", username: "Adam A", password: "11111", userPic: 1)
        let comment = Rating(user: user, rating: 8.4, comment: "This is a great course balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla!")
        let comment2 = Rating(user: user, rating: 7, comment: "This is a great course balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla! ")
        commentList = [comment,comment2]
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
