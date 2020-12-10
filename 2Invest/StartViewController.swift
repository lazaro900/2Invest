//
//  StartViewController.swift
//  2Invest
//
//  Created by Lazaro Alvelaez on 12/6/20.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var aboutButton: UIButton!
    @IBOutlet weak var companiesButton: UIButton!
    @IBOutlet weak var informationButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        aboutButton.layer.cornerRadius = 20
        companiesButton.layer.cornerRadius = 20
        informationButton.layer.cornerRadius = 20
        Companies.page = 1
        MyStocksViewController.orangeColor = aboutButton.backgroundColor

    }
    

    
}
