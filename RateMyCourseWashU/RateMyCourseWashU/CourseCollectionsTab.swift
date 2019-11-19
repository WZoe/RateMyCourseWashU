//
//  CourseCollectionsTab.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/17/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class CourseCollectionsTab: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var courseSearchResults:[Course] = []
    var professorSearchResults:[Professor] = []
    var courseList:[Course] = []
    var professorList:[Professor] = []
    var currentSeg:Int = 0 //0:course, 1:professor, 2:by rating, 3:by department
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: view.frame.width, height: 200)
            flow.minimumInteritemSpacing = 5
            flow.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
        collectionView.register(CourseCell.self, forCellWithReuseIdentifier: "courseCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hoc = 200
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) as! CourseCell
        cell.number = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: hoc*0.05, width: view.frame.width*0.8, height: hoc*0.2))
        cell.number.font = cell.number.font.withSize(hoc*0.075)
        cell.number.text = courseList[indexPath.row].courseNumber
        
        cell.title = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: hoc*0.3, width: view.frame.width*0.8, height: hoc*0.2))
        cell.title.font = cell.title.font.withSize(hoc*0.18)
        cell.title.text = courseList[indexPath.row].title
        
        cell.professor = UILabel(frame: CGRect(x: view.frame.width * 0.1, y: hoc*0.5, width: view.frame.width*0.8, height: hoc*0.2))
        cell.professor.font = cell.professor.font.withSize(hoc*0.1)
        cell.professor.text = courseList[indexPath.row].title
        
        cell.rating = UIProgressView(frame: CGRect(x: view.frame.width * 0.1, y: hoc*0.7, width: view.frame.width*0.8, height: hoc*0.2))
        cell.rating.progress = courseList[indexPath.row].overallRating
        
        
        cell.addSubview(cell.number)
        cell.addSubview(cell.title)
        cell.addSubview(cell.professor)
        cell.addSubview(cell.rating)
        
        return cell as UICollectionViewCell
    }
    
    // todo: 获取courseList
    func initCourseList() {
        let course1 = Course(id: "1", title: "Mobile Application Development", courseNumber: "A22.22.2222.AA.01", professor: "Todd Sproull", department: "Computer Science and Engineering", overallRating: 9.5)
        let course2 = Course(id: "2", title: "Data Structure and Algorithm", courseNumber: "B22.23.2.42.3423.52.B.02", professor: "First Last", department: "Computer Science and Engineering", overallRating: 9.4)
        let course3 = Course(id: "3", title: "AAA", courseNumber: "A.A.A", professor: "First Last", department: "BB", overallRating: 5.4)
        let course4 = Course(id: "4", title: "BSAA", courseNumber: "SADAF.SA", professor: "First Last", department: "BBAAA", overallRating: 7.0)
        courseList = [course1, course2,course3,course4]
    }
    
    // todo: 当segment change时更改标题和currentSeg
    
    // search for a course:
    @IBAction func search(_ sender: UITextField) {
        //todo: search func
    }
    
    // push to course detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "detail view") as CourseDetailVC!
        detailvc.currentCourse = courseList[indexPath.row]
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
}
