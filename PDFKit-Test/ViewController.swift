//
//  ViewController.swift
//  PDFKit-Test
//
//  Created by Gonet on 09/04/18.
//  Copyright © 2018 Gonet. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {
    var pdfdocument: PDFDocument?
    
    var pdfview: PDFView!
    var pdfthumbView: PDFThumbnailView!
    let toolView = ToolView.instanceFromNib()
    weak var observe : NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolView.frame = CGRect(x: 110, y: view.frame.height - 640, width: self.view.frame.width - 240, height: 40)
        
        pdfview = PDFView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        let url = Bundle.main.url(forResource: "iOSCourse", withExtension: "pdf")
        pdfdocument = PDFDocument(url: url!)
        
        pdfview.document = pdfdocument
        pdfview.displayMode = PDFDisplayMode.singlePageContinuous
        pdfview.autoScales = true
        
        self.view.addSubview(pdfview)
        
        self.view.addSubview(toolView)
        toolView.bringSubview(toFront: self.view)
        toolView.searchBtn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        toolView.outlineBtn.addTarget(self, action: #selector(outlineBtnClick), for: .touchUpInside)
        
    }
    
    @objc func tapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: CATransaction.animationDuration()) { [weak self] in
            self?.toolView.alpha = 1 - (self?.toolView.alpha)!
        }
    }
    
    @objc func outlineBtnClick(sender: UIButton) {
        
        if let pdfoutline = pdfdocument?.outlineRoot {
            let oulineViewController = OulineTableviewController(style: UITableViewStyle.plain)
            oulineViewController.pdfOutlineRoot = pdfoutline
            oulineViewController.delegate = self as OulineTableviewControllerDelegate
            
            let nav = UINavigationController(rootViewController: oulineViewController)
            self.present(nav, animated: false, completion:nil)
        }
        
    }
    
    
    @objc func searchBtnClick(sender: UIButton) {
        let searchViewController = SearchTableViewController()
        searchViewController.pdfDocument = pdfdocument
        searchViewController.delegate = self
        
        let nav = UINavigationController(rootViewController: searchViewController)
        self.present(nav, animated: false, completion:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: OulineTableviewControllerDelegate {
    func oulineTableviewController(_ oulineTableviewController: OulineTableviewController, didSelectOutline outline: PDFOutline) {
        let action = outline.action
        if let actiongoto = action as? PDFActionGoTo {
            pdfview.go(to: actiongoto.destination)
        }
    }
}


extension ViewController: SearchTableViewControllerDelegate {
    func searchTableViewController(_ searchTableViewController: SearchTableViewController, didSelectSerchResult selection: PDFSelection) {
        selection.color = UIColor.yellow
        pdfview.currentSelection = selection
        pdfview.go(to: selection)
    }
}

