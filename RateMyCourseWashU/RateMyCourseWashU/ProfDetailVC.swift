//
//  ProfDetailVC.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/19/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class ProfDetailVC: UIViewController {
    
    var currentProf: Professor? = nil
    
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
    
}
