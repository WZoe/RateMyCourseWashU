//
//  ProfessorCollections.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/19/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire
class ProfessorCollections: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var professorSearchResults:[Professor] = []
    var professorList:[Professor] = []

    @IBOutlet weak var nav: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nav.setHidesBackButton(true, animated: false)
        
        initProfList()
        setCollectionView()
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    func setCollectionView() {
        collectionView.backgroundColor = #colorLiteral(red: 0.5180335641, green: 0.7032366395, blue: 0.6400405765, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: view.frame.width, height: 80)
            flow.minimumInteritemSpacing = 1
            flow.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        }
        collectionView.register(ProfCell.self, forCellWithReuseIdentifier: "profCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return professorList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hoc = CGFloat(80)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "profCell", for: indexPath) as! ProfCell
        
        cell.name = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.15, width: view.frame.width*0.9, height: hoc*0.45))
        cell.name!.font = cell.name!.font.withSize(hoc*0.3)
        cell.name!.text = professorList[indexPath.row].name
        
        cell.department = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.6, width: view.frame.width*0.9, height: hoc*0.2))
        cell.department!.font = cell.department!.font.withSize(hoc*0.17)
        cell.department!.text = professorList[indexPath.row].department
        
        cell.rating = UIProgressView(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.9, width: view.frame.width*0.9, height: hoc*0.1))
        cell.rating!.progress = Float(professorList[indexPath.row].rating*0.1)
        
        
        cell.addSubview(cell.name!)
        cell.addSubview(cell.department!)
        cell.addSubview(cell.rating!)
        
        cell.layer.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        return cell as UICollectionViewCell
    }
    
    // todo: 获取professorList
    func initProfList() {
//        let prof1 = Professor(id: "1", name: "Todd Sproull", rating: 9.0, department: "Computer Science and Engineering")
//        let prof2 = Professor(id: "2", name: "Todd Spring", rating: 4.5, department: "Computer Science and Engineering")
//        let prof3 = Professor(id: "3", name: "Todd Sproll", rating: 6.5, department: "Computer Science and Engineering")
//        let prof4 = Professor(id: "4", name: "Todd Sprill", rating: 7.3, department: "Computer Science and Engineering")
//        let prof5 = Professor(id: "5", name: "Todd Spill", rating: 8.8, department: "Computer Science and Engineering")
//
//        professorList = [prof1, prof2, prof3, prof4, prof5]
        AF.request("http://52.170.3.234:3456/professorList",
                   method: .post,
                   parameters: ["":""],
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    debugPrint(response)
                    let json = JSON(response.data!)
                    for (_, j):(String, JSON) in json{
                        let p = Professor(id: j["id"].stringValue,
                                          name: j["name"].stringValue,
                                          rating: j["rating"].doubleValue / 10,
                                          department:j["department"].stringValue)
                        
                        self.professorList.append(p)
                    }
                    self.collectionView.reloadData()
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // change seg
    
    @IBAction func seg(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let coursecollection = self.storyboard?.instantiateViewController(withIdentifier: "coursecollection") as! CourseCollectionsTab
            navigationController?.pushViewController(coursecollection, animated: false)
        }
    }
    
    //todo: search prof
    
    //todo: push prof detail
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailvc = self.storyboard?.instantiateViewController(withIdentifier: "profdetail") as! ProfDetailVC
//        detailvc.currentCourse = courseList[indexPath.row]
        navigationController?.pushViewController(detailvc, animated: true)
    }
    
}
