//
//  MyPicCell.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 12/1/19.
//  Copyright © 2019 438group. All rights reserved.
//

import UIKit

class MyPicCell: UICollectionViewCell {
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var selectedLabel: UILabel!
    
    //set selected cell background: https://stackoverflow.com/questions/30598664/how-can-i-highlight-selected-uicollectionview-cells-swift
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                print("selectedcell")
                self.backgroundColor = UIColor.init(red: 148/255, green: 37/255, blue: 31/255, alpha: 1.0)
            }
            else {
                self.backgroundColor = .clear
            }
        }
    }
    
}
