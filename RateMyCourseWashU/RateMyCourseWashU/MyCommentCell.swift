//
//  MyCommentCell.swift
//  RateMyCourseWashU
//
//  Created by 沈晓知 on 11/29/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation
import UIKit

class MyCommentCell: UICollectionViewCell {
    var coursename: UILabel? = nil
    //var profname: UILabel? = nil
    var comment: UITextView? = nil
    var rating: CosmosView? = nil
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coursename!.removeFromSuperview()
       // profname!.removeFromSuperview()
        comment!.removeFromSuperview()
        rating!.removeFromSuperview()
    }
}
