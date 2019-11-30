//
//  MyRatingViewController.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/28/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire
class MyRatingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var commentList:[MyComment] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //Todo: fetch the ratings and comments the user has made
    //store results in commentList
    func initCommentList() {
//        let comment = MyComment(course:"CSE438: IOS Mobile Application",rating: 8.4, comment: "This is a great course balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla!")
//        let comment2 = MyComment(course:"CSE438: IOS Mobile Application",rating: 8.4, comment: "This is a great course balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla! This is a great course balabalabalabalbalbabla!")
//        commentList = [comment,comment2]
        AF.request("http://52.170.3.234:3456/getCourseCommentListByUser",
                   method: .post,
                   //done by zoe: update courseID here
            parameters: ["userID":cache.object(forKey: "userid") as! String],
            encoder: JSONParameterEncoder.default).responseJSON { response in
                debugPrint(response)
                let json = JSON(response.data!)
                for (_, j):(String, JSON) in json{
                    let comment = MyComment(course: j["courseDept"].stringValue + " " + j["courseCode"].stringValue + " " + j["courseName"].stringValue, rating: j["rating"].doubleValue / 10, comment: j["comment"].stringValue)
                    self.commentList.append(comment)
                }
                self.collectionView.reloadData()
        }
    }
    
    func setCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: view.frame.width, height: 100)
        }
        collectionView.register(MyCommentCell.self, forCellWithReuseIdentifier: "myCommentCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let hoc = CGFloat(75)
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCommentCell", for: indexPath) as! MyCommentCell
        
        cell.coursename = UILabel(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.05, width: view.frame.width*0.7, height: hoc*0.4))
        cell.coursename?.text = commentList[indexPath.row].course + ":"
        
        cell.comment = UITextView(frame: CGRect(x: view.frame.width * 0.05, y: hoc*0.45, width: view.frame.width*0.9, height: hoc*0.6))
        cell.comment?.text = commentList[indexPath.row].comment
        cell.comment?.font = UIFont.systemFont(ofSize: 16)
        cell.comment?.isEditable = false
        
        cell.rating = CosmosView(frame: CGRect(x: view.frame.width * 0.7, y: hoc*0.1, width: view.frame.width*0.35, height: hoc*0.4))
        cell.rating?.settings.fillMode = .precise
        cell.rating?.settings.updateOnTouch = false
        cell.rating?.rating = commentList[indexPath.row].rating / 2
        cell.rating?.settings.starSize = 18
        
        
        cell.addSubview(cell.coursename!)
        cell.addSubview(cell.comment!)
        cell.addSubview(cell.rating!)
        
        cell.layer.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        return cell as UICollectionViewCell
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        setCollectionView()
        initCommentList()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
