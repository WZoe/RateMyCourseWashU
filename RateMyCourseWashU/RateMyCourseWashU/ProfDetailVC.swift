//
//  ProfDetailVC.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/19/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class ProfDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentProf: Professor? = nil
    var commentList: [Rating] = []
    
    @IBOutlet weak var navtitle: UINavigationItem!
    
    @IBOutlet weak var star: CosmosView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var dep: UILabel!
    @IBOutlet weak var profTitle: UILabel!
    
    @IBOutlet weak var userR: UILabel!
    @IBAction func slider(_ sender: UISlider) {
        userR.text =  String(format: "%.1f", sender.value * 10) //123.32
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateValue()
        // Do any additional setup after loading the view.
        initCommentList()
        setCollectionView()
    }
    
    func updateValue() {
        navtitle.title = currentProf?.name
        profTitle.text = currentProf?.name
        dep.text = currentProf?.department
        rating.text = String(currentProf!.rating)
        star.rating = currentProf!.rating / 2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // TODO: follow prof
    @IBAction func follow(_ sender: UIButton) {
    }
    
    // TODO: submit rating
    // @prof, currentUser, rating, comment
    @IBAction func submit(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    // TODO: fetch ratings for this course
    func initCommentList() {
        let user = User(userID: "1111", username: "Adam A", password: "11111", userPic: 1)
        let comment = Rating(user: user, rating: 8.4, comment: "This is a great prof balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla!")
        let comment2 = Rating(user: user, rating: 7, comment: "This is a great prof balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla! ")
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
