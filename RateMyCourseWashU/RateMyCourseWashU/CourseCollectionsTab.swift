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
        setCollectionView()
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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: view.frame.width, height: 180)
            flow.minimumInteritemSpacing = 5
            flow.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        }
        collectionView.register(CourseCell.self, forCellWithReuseIdentifier: "courseCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) as! CourseCell
        cell.number.font = cell.number.font.withSize(15)
        cell.number.text = courseList[indexPath.row].courseNumber
        
        cell.title.font = cell.title.font.withSize(25)
        cell.title.text = courseList[indexPath.row].title
        
        // todo: other properties
        
        cell.addSubview(cell.number)
        cell.addSubview(cell.title)
        
        return cell as UICollectionViewCell
    }
    
    // todo: 获取courseList
    
    // todo: 当segment change时更改标题和currentSeg

}
