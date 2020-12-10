//
//  DetailViewController.swift
//  2Invest
//
//  Created by Lazaro Alvelaez on 12/1/20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var marketLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    @IBOutlet weak var lowLabel: UILabel!

    @IBOutlet weak var addButtonPressed: UIButton!
    @IBOutlet weak var returnHomeButton: UIButton!
    
    var cameFromDetail = true
    var companyInfo: Company!
    var dailyInfo: Daily!
    var name: String!
    var ticker = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonPressed.isHidden = !cameFromDetail
        returnHomeButton.isHidden = !cameFromDetail
        
        navigationController?.navigationBar.barTintColor = MyStocksViewController.orangeColor
        
        
        guard let url = URL(string: "https://s3.polygon.io/logos/\(ticker.lowercased())/logo.png") else {return}
        do {
            let data = try Data(contentsOf: url)
            self.companyImageView.image = UIImage(data: data)
        } catch {
            print("😡 ERROR: error thrown tryign to get imag from url \(url)")
        }
        
        if companyInfo == nil {
            companyInfo = Company(ticker: "", name: "", market: "", locale: "", currency: "", active: true, primaryExch: "", updated: "")
        }
        updateUserInterface()
        
    }
    
    func updateUserInterface() {
        
        
        nameLabel.text = companyInfo.name
        marketLabel.text = companyInfo.primaryExch
        countryLabel.text = companyInfo.locale
        currencyLabel.text = companyInfo.currency
        tickerLabel.text = companyInfo.ticker
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print(ViewController.dailyURL)
            self.openLabel.text = "$\(self.dailyInfo.company.open)"
            self.closeLabel.text = "$\(self.dailyInfo.company.close)"
            self.highLabel.text = "$\(self.dailyInfo.company.high)"
            self.lowLabel.text = "$\(self.dailyInfo.company.low)"
            
        }
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddStock" {
            let destination = segue.destination as! MyStocksViewController
            destination.passedCompany = companyInfo
        }
        cameFromDetail = true

    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
    }
    


}

extension Date {

    var dayBefore: String {
        var today = Date().addingTimeInterval(-86400)
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy-MM-dd"

        let result = formatter.string(from: today)
        
        return result
    }
}
