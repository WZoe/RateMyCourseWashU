//
//  CourseCollectionsTab.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
class CourseCollectionsTab: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var nav: UINavigationItem!
    var courseSearchResults:[Course] = []
    var professorSearchResults:[Professor] = []
    var courseList:[Course] = []
    var professorList:[Professor] = []
    var currentSeg:Int = 0 //0:course, 1:professor, 2:by rating, 3:by department
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nav.setHidesBackButton(true, animated: false)
        initCourseList()
        setCollectionView()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    func setCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.5180335641, green: 0.7032366395, blue: 0.6400405765, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: view.frame.width, height: 100)
            flow.minimumInteritemSpacing = 1
            flow.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        }
        collectionView.register(CourseCell.self, forCellWithReuseIdentifier: "courseCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hoc = CGFloat(100)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) as! CourseCell
        
        cell.number = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.1, width: view.frame.width*0.9, height: hoc*0.2))
        cell.number!.font = cell.number!.font.withSize(hoc*0.15)
        cell.number!.text = courseList[indexPath.row].courseNumber
        
        cell.title = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.4, width: view.frame.width*0.9, height: hoc*0.2))
        cell.title!.font = cell.title!.font.withSize(hoc*0.2)
        cell.title!.text = courseList[indexPath.row].title
        
        cell.professor = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.6, width: view.frame.width*0.9, height: hoc*0.2))
        cell.professor!.font = cell.professor!.font.withSize(hoc*0.17)
        cell.professor!.text = courseList[indexPath.row].professor.name
        
        cell.rating = UIProgressView(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.9, width: view.frame.width*0.9, height: hoc*0.1))
        cell.rating!.progress = Float(courseList[indexPath.row].overallRating*0.1)
        
        
        cell.addSubview(cell.number!)
        cell.addSubview(cell.title!)
        cell.addSubview(cell.professor!)
        cell.addSubview(cell.rating!)
        
        cell.layer.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
//        cell.layer.borderWidth = 2
        return cell as UICollectionViewCell
    }
    
    // todo: 获取courseList
    func initCourseList() {
//        let prof = Professor(id: "1", name: "Todd Sproull", rating: 9.0, department: "Computer Science and Engineering")
//        let course1 = Course(id: "1", title: "Mobile Application Development", courseNumber: "A22.22.2222.AA.01", professor: prof, department: "Computer Science and Engineering", overallRating: 9.5)
//        let course2 = Course(id: "2", title: "Some course from CSE", courseNumber: "B22.23.2.42.3423.52.B.02", professor: prof, department: "Computer Science and Engineering", overallRating: 9.4)
//        let course3 = Course(id: "3", title: "AAA", courseNumber: "A.A.A", professor: prof, department: "BB", overallRating: 5.4)
//        let course4 = Course(id: "4", title: "BSAA", courseNumber: "SADAF.SA", professor: prof, department: "BBAAA", overallRating: 7.0)
//        let course5 = Course(id: "2", title: "Some course from CSE", courseNumber: "B22.23.2.42.3423.52.B.02", professor: prof, department: "Computer Science and Engineering", overallRating: 2.4)
//        let course6 = Course(id: "2", title: "Some course from CSE", courseNumber: "B22.23.2.42.3423.52.B.02", professor: prof, department: "Computer Science and Engineering", overallRating: 5.3)
//        let course8 = Course(id: "2", title: "Some course from CSE", courseNumber: "B22.23.2.42.3423.52.B.02", professor: prof, department: "Computer Science and Engineering", overallRating: 6.3)
//        let course9 = Course(id: "2", title: "Some course from CSE", courseNumber: "B22.23.2.42.3423.52.B.02", professor: prof, department: "Computer Science and Engineering", overallRating: 8.2)
//        courseList = [course1, course2,course3,course4,course5, course6,  course8, course9]
        AF.request("http://52.170.3.234:3456/courseList",
                   method: .post,
                   parameters: ["":""],
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    debugPrint(response)
                    let json = JSON(response.data!)
                    for (_, j):(String, JSON) in json{
                        let p = Professor(id: j["proID"].stringValue,
                                          name: j["proName"].stringValue,
                                          rating: j["rating"].doubleValue / 10,
                                          department:j["department"].stringValue)
                        let course = Course(id: j["courseID"].stringValue,
                                            title: j["title"].stringValue,
                                            courseNumber: j["courseNumber"].stringValue,
                                            professor:p,
                                            department: j["department"].stringValue,
                                            overallRating: j["rating"].doubleValue / 10)
                        self.courseList.append(course)
                    }
                    self.collectionView.reloadData()
        }
    }
    // todo: 当segment change时更改标题和currentSeg
    
    @IBAction func seg(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            let profcollection = self.storyboard?.instantiateViewController(withIdentifier: "profcollection") as! ProfessorCollections
            navigationController?.pushViewController(profcollection, animated: false)
        }
    }
    
    // search for a course:
    @IBAction func search(_ sender: UITextField) {
        //todo: search func
    }
    
    // push to course detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "detailvc") as! CourseDetailVC
        detailvc.currentCourse = courseList[indexPath.row]
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
}
