//
//  banner.swift
//  RateMyCourseWashU
//
//  Created by Zoe Wang on 11/30/19.
//  Copyright © 2019 438group. All rights reserved.
//

import Foundation
import UIKit

func showBanner(superview: UIView, text: String = "Done!", type: Int) {
    //type: 0 - general text, 1 - success, 2 - error
    let sw = superview.frame.width
    let sh = superview.frame.height
    let width = sw * 0.2
    let height = sw * 0.2
    let banner = UIView(frame: CGRect(x:(sw - width)/2, y: (sh - height)/2, width: width, height: height))
    banner.backgroundColor = UIColor.black
    banner.alpha = 0.65
    if type == 1 {
        let picView = UIImageView(frame: CGRect(x:(width - height * 0.7)/2, y: (height - height * 0.7)/2, width: height * 0.7, height: height * 0.7))
        let pic = UIImage(named: "success")
        picView.image = pic
        banner.addSubview(picView)
    }
    else if type == 2 {
        let picView = UIImageView(frame: CGRect(x:(width - height * 0.7)/2, y: (height - height * 0.7)/2, width: height * 0.7, height: height * 0.7))
        let pic = UIImage(named: "error")
        picView.image = pic
        banner.addSubview(picView)
    }
    else {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        label.text = text
        label.font = label.font.withSize(width * 0.12)
        label.textColor = UIColor.white
        label.textAlignment = .center
        banner.addSubview(label)
    }
    
    
    superview.addSubview(banner)
    superview.bringSubviewToFront(banner)
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
        banner.removeFromSuperview()
    }

}
