//
//  InformationViewController.swift
//  2Invest
//
//  Created by Lazaro Alvelaez on 12/9/20.
//

import UIKit

class InformationViewController: UIViewController {
    
    struct Concepts {
        var name: String
        var description: String
    }
    
    var concepts: [Concepts] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        concepts.append(Concepts(name: "Stock Market", description: "The stock market refers to the collection of markets and exchanges where regular activities of buying, selling, and issuance of shares of publicly-held companies take place."))
        concepts.append(Concepts(name: "Initial Public Offering", description: "Stocks first become available on an exchange after a company conducts its initial public offering (IPO). A company sells shares to an initial set of public shareholders in an IPO known as the primary market. After the IPO floats shares into the hands of public shareholders, these shares can be sold and purchased on an exchange or the secondary market."))
        concepts.append(Concepts(name: "Stock Exchanges", description: "A stock exchange is where different financial instruments are traded—stocks, commodities, derivatives, etc.—bringing corporations and governments together with investors. The exchange tracks the flow of orders for each stock. This flow of supply and demand sets the stock price."))
        concepts.append(Concepts(name: "Company Ticker", description: "A ticker symbol is an arrangement of characters—usually letters—representing particular securities listed on an exchange or otherwise traded publicly."))
        concepts.append(Concepts(name: "Company Locale", description: "A companie's primary country of operations."))
        concepts.append(Concepts(name: "Primary Market", description: "The primary market that a company's equity is traded in."))
        concepts.append(Concepts(name: "Daily High", description: "Today's high refers to a security's intraday high trading price. Today's high is the highest price at which a stock traded during the course of the trading day."))
        concepts.append(Concepts(name: "Daily Low", description: "Today's low refers to a security's intraday low trading price. Today's low is the lowest price at which a stock traded during the course of the trading day."))
        concepts.append(Concepts(name: "Daily Open", description: "The opening price is the price at which a security first trades upon the opening of an exchange on a trading day; for example, the New York Stock Exchange (NYSE) opens at precisely 9:30 a.m. Eastern time. The price of the first trade for any listed stock is its daily opening price."))
        concepts.append(Concepts(name: "Daily Close", description: "The closing price is the price at which a security last trades upon the closing of an exchange on a trading day."))



        
        tableView.delegate = self
        tableView.dataSource = self

    }
    

    

}

extension InformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return concepts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = concepts[indexPath.row].name
        cell.detailTextLabel?.text = concepts[indexPath.row].description
        cell.textLabel?.frame.origin = (cell.detailTextLabel?.frame.origin)!

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
    
    
}

