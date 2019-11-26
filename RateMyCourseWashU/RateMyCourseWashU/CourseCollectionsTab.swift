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
    
    // TODO: search for a course:
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
