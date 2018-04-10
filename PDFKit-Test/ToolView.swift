//
//  ToolView.swift
//  PDFKit-Test
//
//  Created by Gonet on 09/04/18.
//  Copyright © 2018 Gonet. All rights reserved.
//

import UIKit

class ToolView: UIView {
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var outlineBtn: UIButton!
    
    class func instanceFromNib() -> ToolView {
        return UINib(nibName: "ToolView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ToolView
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
    }
}

