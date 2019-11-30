//
//  StudentsList.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/25/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire
class StudentsList: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var currentCourse: Course? = nil
    var studentList: [User] = []
    var recommendationList: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setTableView()
        initStudentList()
        setCollectionView()
        initRecommendation()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // Table View
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "student")
        
        cell.textLabel?.text = studentList[indexPath.row].username
        
        return cell
    }
    
    func setTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "student")
    }
    
    // TODO: fetch random maximum 15(or any number) of students who have marked this course as taken
    func initStudentList() {
//        let user1 = User(userID: "1", username: "asaf", password: "11", userPic: 1)
//        let user2 = User(userID: "1", username: "zxbz", password: "11", userPic: 1)
//        let user3 = User(userID: "1", username: "eyxbn", password: "11", userPic: 1)
//        let user4 = User(userID: "1", username: "bzliw", password: "11", userPic: 1)
        AF.request("http://52.170.3.234:3456/getStudentsGivenCourseID",
                   method: .post,
                   //done by zoe: update courseID here
            parameters: ["courseID": currentCourse?.id],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                let json = JSON(response.data!)
                for (_, j):(String, JSON) in json{
                    let stu = User(userID: j["userID"].stringValue, username: j["username"].stringValue, password: "don't need", userPic: j["userPic"].intValue)
                    self.studentList.append(stu)
                }
                self.tableView.reloadData()
                
        }
//        studentList = [user1, user2, user3, user4]
    }
    
    // TODO: when click on a student, start a conversation with him
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true

        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: view.frame.width, height: 35)
//            flow.scrollDirection = .horizontal
        }
        collectionView.register(RecCell.self, forCellWithReuseIdentifier: "recCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hoc = CGFloat(35)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recCell", for: indexPath) as! RecCell
        
        cell.backgroundColor = #colorLiteral(red: 0, green: 0.4509990811, blue: 0.3774749637, alpha: 1)
        
        cell.title = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.width - 20, height: hoc))
        cell.title!.font = UIFont.systemFont(ofSize: 17)
        cell.title!.text = recommendationList[indexPath.row].title
        cell.title?.textColor = UIColor.white
        cell.title?.textAlignment = .center
//        cell.title?.isEditable = false
//        cell.title?.backgroundColor = UIColor.clear
        
        cell.addSubview(cell.title!)
        
        return cell as UICollectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "detailvc") as! CourseDetailVC
        detailvc.currentCourse = recommendationList[indexPath.row]
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
    // TODO: fetch recommendations based on the students' course lists
    func initRecommendation() {
//        let p = Professor(id: "1", name: "Todd Sproull", rating: 7.7, department: "CSE")
//        let c1 = Course(id: "1", title: "mobile application development", courseNumber: "438S", professor: p, department: "CSE", overallRating: 9.5)
//        let c2 = Course(id: "1", title: "mobile application development", courseNumber: "438S", professor: p, department: "CSE", overallRating: 9.5)
//        let c3 = Course(id: "1", title: "mobile aplication development", courseNumber: "438S", professor: p, department: "CSE", overallRating: 9.5)
//        let c4 = Course(id: "1", title: "mobile application development", courseNumber: "438S", professor: p, department: "CSE", overallRating: 9.5)
//
//        recommendationList = [c1, c2, c3, c4]
        AF.request("http://52.170.3.234:3456/getRecommandation",
                   method: .post,
            parameters: ["":""],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                let json = JSON(response.data!)
                for (_, j):(String, JSON) in json{
                    let c = Course(id: j["courseID"].stringValue, title: j["courseName"].stringValue, courseNumber: j["courseCode"].stringValue, professor: Professor(id: "1", name: " ", rating: 10.0, department: j["courseDept"].stringValue), department: j["courseDept"].stringValue, overallRating: j["rating"].doubleValue / 10)
                    self.recommendationList.append(c)
                }
                self.collectionView.reloadData()
        }
    }
}
