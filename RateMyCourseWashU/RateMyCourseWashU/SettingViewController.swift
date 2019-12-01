//
//  SettingViewController.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var myPic: UIImageView!
    
    @IBAction func changePic(_ sender: Any) {
        let detailedVC = storyboard?.instantiateViewController(withIdentifier: "ChangeUserPicVC")as?ChangeUserPicVC
        self.navigationController?.pushViewController(detailedVC!, animated: true)
        
    }
    //reference:https://stackoverflow.com/questions/17355280/how-to-add-a-border-just-on-the-top-side-of-a-uiview
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat, view:UIView) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: view.frame.size.height - borderWidth, width: view.frame.size.width, height: borderWidth)
        view.addSubview(border)
    }
    
    @IBOutlet weak var changeView: UIView!{
        didSet{
            addBottomBorder(with: .lightGray, andWidth: 1.0, view: changeView)
        }
    }
    
    
    
    var userimage:Int=0
    var userid=(cache.object(forKey: "userid")as! NSString) as String
    
    //upload userimage to database
    @IBAction func resetPic(_ sender: Any) {
        
    }
    
    @IBAction func logout(_ sender: Any) {
        cache.removeAllObjects()
        //push back to log in scene
    
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainViewController")as?ViewController
        self.navigationController?.pushViewController(mainVC!, animated: true)
    }
    
    override func viewDidLoad() {
        if ((cache.object(forKey: "userimage")) != nil){
            userimage=Int((cache.object(forKey: "userimage")as! NSString) as String)!
        }
        
        myPic.image=UIImage(named: "face\(userimage)")
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
