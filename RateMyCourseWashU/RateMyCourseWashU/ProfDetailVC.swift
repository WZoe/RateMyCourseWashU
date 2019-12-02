//
//  ProfDetailVC.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/19/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire

class ProfDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var currentProf: Professor? = nil
    var commentList: [Rating] = []
    
    @IBOutlet weak var navtitle: UINavigationItem!
    
    @IBOutlet weak var star: CosmosView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var dep: UILabel!
    @IBOutlet weak var profTitle: UILabel!
    
    @IBOutlet weak var comment: UITextField!
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
        rating.text = String(format: "%.1f", currentProf!.rating)
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
        
        AF.request("http://52.170.3.234:3456/followProfessor",
                   method: .post,
                   //done by zoes, update  following parameter
            parameters: ["userID":cache.object(forKey: "userid") as String?, "proID":currentProf?.id],
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    debugPrint(response)
                    var json = JSON(response.data!)
                    if json["Success"].boolValue == true {
                        //done by zoe: 弹出submit 成功信息提示
                        showBanner(superview: self.view, type: 1)
                    }
                    else{
                        //failre case
                        showBanner(superview: self.view, type: 2)
                    }
        }
    }
    
    // TODO: submit rating
    // @prof, currentUser, rating, comment
    @IBAction func submit(_ sender: UIButton) {
        let rating  = Int((userR.text! as NSString).doubleValue * 10)
        let parameters: [String: String] = [
            //done by zoe, 下列信息需要获取
            "userID":cache.object(forKey: "userid")! as String,
            "proID":currentProf!.id,
            "comment":comment.text!,
            "rating":String(rating) //一样的这里获取的是十进制
        ]
        
        AF.request("http://52.170.3.234:3456/submitProfessorComment",
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    debugPrint(response)
                    var json = JSON(response.data!)
                    if json["Success"].boolValue == true {
                        //done by zoe: 弹出submit 成功信息提示
                        showBanner(superview: self.view, type: 1)
                        self.commentList = []
                        AF.request("http://52.170.3.234:3456/getProfessorCommentList",
                                   method: .post,
                                   //done by zoe: update proID here
                            parameters: ["proID":self.currentProf?.id],
                            encoder: JSONParameterEncoder.default).responseJSON { response in
                                debugPrint(response)
                                let json = JSON(response.data!)
                                for (_, j):(String, JSON) in json{
                                    let r = Rating(user: User(userID: j["userID"].stringValue, username: j["userName"].stringValue, password: "why we need this", userPic: j["userPic"].intValue),
                                                        rating: j["rating"].doubleValue / 10,
                                                        comment: j["comment"].stringValue)
                                    self.commentList.append(r)
                                    
                                    // update rating
                                    let ratingNum = Double(self.commentList.count - 1)
                                    var newR:Double
                                    if ratingNum == 0 {
                                        newR = Double(rating/10)
                                    }
                                    else{
                                        let newA = ((self.currentProf!.rating * ratingNum) + Double(rating/10))
                                        newR = newA  / (ratingNum + 1)
                                    }
                                    
                                    self.rating.text =  String(format: "%.1f", newR)
                                    self.star.rating = newR / 2
                                    self.collectionView.reloadData()
                                }
                                
                        }
                       
                    }
                    else{
                        //failre case
                        showBanner(superview: self.view, type: 2)
                    }
        }
        
        
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    // TODO: fetch ratings for this course
    func initCommentList() {
        self.commentList = []
        AF.request("http://52.170.3.234:3456/getProfessorCommentList",
                   method: .post,
                   //done by zoe: update proID here
                   parameters: ["proID":currentProf?.id],
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    debugPrint(response)
                    let json = JSON(response.data!)
                    for (_, j):(String, JSON) in json{
                        let rating = Rating(user: User(userID: j["userID"].stringValue, username: j["userName"].stringValue, password: "why we need this", userPic: j["userPic"].intValue),
                                            rating: j["rating"].doubleValue / 10,
                                            comment: j["comment"].stringValue)
                        self.commentList.append(rating)
                    }
                    self.collectionView.reloadData()
        }
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
