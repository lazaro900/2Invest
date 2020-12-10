//
//  AboutViewController.swift
//  2Invest
//
//  Created by Lazaro Alvelaez on 12/8/20.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentWidth = scrollView.bounds.width
        let contentHeight = scrollView.bounds.height * 1.2
        scrollView.contentSize = CGSize(width: contentWidth, height: contentHeight)


    }
    

}
