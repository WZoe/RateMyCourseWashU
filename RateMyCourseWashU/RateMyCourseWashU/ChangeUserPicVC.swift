//
//  ChangeUserPicVC.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 12/1/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class ChangeUserPicVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    

    @IBOutlet weak var collectionview: UICollectionView!

    var selectedRow: String=""
    @IBOutlet weak var currentPic: UIImageView!
    
    // TODO by cst: update userpic on server
    @IBAction func setPic(_ sender: Any) {
        self.currentPic.image=UIImage(named: "face\(selectedRow)")
        cache.setObject(selectedRow as NSString, forKey: "userimage")
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
        selectedRow=String(indexPath.row)
        cell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
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
