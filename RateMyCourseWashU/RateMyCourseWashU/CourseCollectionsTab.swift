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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nav.setHidesBackButton(true, animated: false)
        initCourseList()
        setCollectionView()
    }
    override func viewDidAppear(_ animated: Bool) {
        initCourseList()
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
//        collectionView.backgroundColor = 
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: view.frame.width, height: 100)
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
        
        cell.title = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.3, width: view.frame.width*0.9, height: hoc*0.3))
        cell.title!.font = cell.title!.font.withSize(hoc*0.25)
        cell.title!.text = courseList[indexPath.row].title
        
        cell.professor = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.6, width: view.frame.width*0.9, height: hoc*0.2))
        cell.professor!.font = cell.professor!.font.withSize(hoc*0.17)
        cell.professor!.text = courseList[indexPath.row].professor.name
        
        cell.rating = CosmosView(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.8, width: view.frame.width*0.9, height: hoc*0.2))
        cell.rating?.settings.fillMode = .precise
        cell.rating?.settings.updateOnTouch = false
        cell.rating?.rating = courseList[indexPath.row].overallRating / 2
        cell.rating?.settings.starSize = 25
        
        
        cell.addSubview(cell.number!)
        cell.addSubview(cell.title!)
        cell.addSubview(cell.professor!)
        cell.addSubview(cell.rating!)
        
        cell.layer.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
//        cell.layer.borderWidth = 1
        return cell as UICollectionViewCell
    }
    
    // todo: 获取courseList
    func initCourseList() {
        var flag = false
        AF.request("http://52.170.3.234:3456/courseList",
                   method: .post,
                   parameters: ["":""],
                   encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).responseJSON { response in
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        let json = JSON(response.data!)
                        for (_, j):(String, JSON) in json{
                            let p = Professor(id: j["proID"].stringValue,
                                              name: j["proName"].stringValue,
                                              rating: j["proRating"].doubleValue / 10,
                                              department:j["department"].stringValue)
                            let course = Course(id: j["courseID"].stringValue,
                                                title: j["title"].stringValue,
                                                courseNumber: j["courseNumber"].stringValue,
                                                professor:p,
                                                department: j["department"].stringValue,
                                                overallRating: j["rating"].doubleValue / 10)
                            for i in 0..<self.courseList.count {
                                if self.courseList[i].id == course.id {
                                    flag = true
                                    self.courseList[i] = course
                                    break
                                }
                            }
                            if flag == false {
                                self.courseList.append(course)
                            }
                            self.collectionView.reloadData()
                        }
                    case let .failure(_):
                        showBanner(superview: self.view, type: 2)
                    }
                    
        }
    }
    
    // change seg
    @IBAction func toProf(_ sender: UIButton) {
            let profcollection = self.storyboard?.instantiateViewController(withIdentifier: "profcollection") as! ProfessorCollections
            navigationController?.pushViewController(profcollection, animated: false)
    }
    
    
    @IBOutlet weak var depButton: UIButton!
    @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var profButton: UIButton!
    @IBOutlet weak var coursesButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    // by rating:
    func byRating() {
        coursesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        coursesButton.setTitleColor(UIColor.white, for: .normal)
        coursesButton.backgroundColor = #colorLiteral(red: 0, green: 0.4509990811, blue: 0.3774749637, alpha: 1)
        
        ratingButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        ratingButton.setTitleColor(UIColor.black, for: .normal)
        ratingButton.backgroundColor = UIColor.white
        
        depButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        depButton.setTitleColor(UIColor.white, for: .normal)
        depButton.backgroundColor = #colorLiteral(red: 0.5198733211, green: 0.6998378634, blue: 0.6403132677, alpha: 1)
        
        stackView.distribution = .fillProportionally
    }
    
    @IBAction func toRating(_ sender: UIButton) {
        byRating()
        // sort course by rating and reload
        courseList.sort(by: { $0.overallRating > $1.overallRating })
        collectionView.reloadData()
    }
    
    // by dep:
    func byDep() {
        coursesButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        coursesButton.setTitleColor(UIColor.white, for: .normal)
        coursesButton.backgroundColor = #colorLiteral(red: 0, green: 0.4509990811, blue: 0.3774749637, alpha: 1)
        
        ratingButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        ratingButton.setTitleColor(UIColor.white, for: .normal)
        ratingButton.backgroundColor = #colorLiteral(red: 0, green: 0.4509990811, blue: 0.3774749637, alpha: 1)
        
        depButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        depButton.setTitleColor(UIColor.black, for: .normal)
        depButton.backgroundColor = UIColor.white
        
        stackView.distribution = .fillProportionally
    }
    
    @IBAction func toDep(_ sender: UIButton) {
        byDep()
        //sort by dep and reload
        courseList.sort(by: { $0.department > $1.department })
        collectionView.reloadData()
    }
    
    // course:
    func course() {
        coursesButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        coursesButton.setTitleColor(UIColor.black, for: .normal)
        coursesButton.backgroundColor = UIColor.white
        
        ratingButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        ratingButton.setTitleColor(UIColor.white, for: .normal)
        ratingButton.backgroundColor = #colorLiteral(red: 0, green: 0.4509990811, blue: 0.3774749637, alpha: 1)
        
        depButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        depButton.setTitleColor(UIColor.white, for: .normal)
        depButton.backgroundColor = #colorLiteral(red: 0.5198733211, green: 0.6998378634, blue: 0.6403132677, alpha: 1)
        
        stackView.distribution = .fillProportionally
    }
    
    @IBAction func toCourse(_ sender: UIButton) {
        course()
        // original order
        courseList = []
        initCourseList()
        collectionView.reloadData()
    }
    
    
    // TODO: search for a course:
    @IBAction func search(_ sender: UITextField) {
        //todo: search func
        if let text = sender.text {
            AF.request("http://52.170.3.234:3456/searchCourse",
                       method: .post,
                       parameters: ["keyword":text],
                       encoder: JSONParameterEncoder.default).responseJSON { response in
                        debugPrint(response)
                        switch response.result {
                        case .success:
                            self.courseList.removeAll()
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
                        case .failure(_):
                            showBanner(superview: self.view, type: 2)
                        }
            }
        }
        
    }
    
    // push to course detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "detailvc") as! CourseDetailVC
        detailvc.currentCourse = courseList[indexPath.row]
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
}
