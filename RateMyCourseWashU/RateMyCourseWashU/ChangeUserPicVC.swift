//
//  ChangeUserPicVC.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 12/1/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit
import Alamofire
import SwiftJWT

class ChangeUserPicVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let picURL = ["https://img.icons8.com/emoji/96/000000/man-student.png", "https://img.icons8.com/emoji/96/000000/man-facepalming.png", "https://img.icons8.com/emoji/96/000000/raccoon.png", "https://img.icons8.com/emoji/96/000000/tropical-fish.png", "https://img.icons8.com/emoji/96/000000/turtle-emoji.png", "https://img.icons8.com/emoji/48/000000/cherry-blossom.png", "https://img.icons8.com/emoji/96/000000/woman-student.png", "https://img.icons8.com/emoji/96/000000/woman-facepalming.png", "https://img.icons8.com/emoji/96/000000/sparkling-heart.png" ]

    @IBOutlet weak var collectionview: UICollectionView!

    var selectedRow: String=""
    @IBOutlet weak var currentPic: UIImageView!
    
    
    @IBAction func setPic(_ sender: Any) {
        self.currentPic.image=UIImage(named: "face\(selectedRow)")
        cache.setObject(selectedRow as NSString, forKey: "userimage")
        AF.request("http://52.170.3.234:3456/setUserPic",
                   method: .post,
                   parameters: ["userID":(cache.object(forKey: "userid")as! NSString) as String,
                                "photoID":selectedRow],
                   encoder: JSONParameterEncoder.default).responseJSON { response in
                    debugPrint(response)
        }
        
        // update pusher avatar
        let url = URL(string: "\(ep)/users/\(chatkitInfo!.userId)")
        var token = ""
        
        //get token
        let header = Header()
        let now = Date()
        let stamp = Int(now.timeIntervalSince1970)
        let date = Date(timeIntervalSince1970: TimeInterval(stamp))
        
        
        let claim = tokenClaim(instance: "42106c7e-a9e7-4375-b4cc-77e586b4bd58", iss: "api_keys/eac15d6b-742b-4b14-8d14-3d79777364eb", sub: "admin", exp: Date(timeInterval: 3600, since: date), iat: date, su: true)
        var jwt = JWT(header: header, claims: claim)
        let jwtSigner = JWTSigner.hs256(key: "VoojAzI4sSEyTxtkwLbeKXSnjarhit6WdZKitj28GFE=".data(using: .utf8)!)
        do {
            token = try jwt.sign(using: jwtSigner)
        } catch {
            print("error:", error)
        }
                    
        //update pic
        AF.request(url!, method: .put, parameters: ["avatar_url": self.picURL[Int(self.selectedRow)!]], encoding: JSONEncoding.default,headers: ["authorization":"Bearer \(token)"]).responseJSON { response in
            debugPrint(response)
            print("Change UserPic successful!")
            }
        
        
    }
    
    let images:[UIImage]=[UIImage(named:"face0")!,UIImage(named:"face1")!,UIImage(named:"face2")!,UIImage(named:"face3")!,UIImage(named:"face4")!,UIImage(named:"face5")!,UIImage(named:"face6")!,UIImage(named:"face7")!,UIImage(named:"face8")!]
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func setCollectionView() {
        //        collectionView.backgroundColor =
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.allowsSelection = true
        if let flow = collectionview.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.itemSize = CGSize(width: 115, height: 115)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPicCell", for: indexPath) as! MyPicCell
        cell.myImage.image=images[indexPath.row]
        cell.myImage.contentMode = .scaleAspectFit
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyPicCell", for: indexPath) as! MyPicCell
//        cell.selectedLabel.text="selected"
//        cell.selectedLabel.textColor = .red
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.gray.cgColor
        selectedRow=String(indexPath.row)
        //cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
    }
    
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) {
//            cell.contentView.backgroundColor = nil
//        }
//    }

    override func viewDidLoad() {
        setCollectionView()
        super.viewDidLoad()

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

}
