//
//  MyStocksViewController.swift
//  2Invest
//
//  Created by Lazaro Alvelaez on 12/4/20.
//

import UIKit

class MyStocksViewController: UIViewController {
    
    struct MyStock: Codable, Equatable {
        var ticker: String
        var name: String
    }
    
    static var orangeColor: UIColor!
    
    @IBOutlet weak var returnHomeButton: UIButton!
    var myStocks: [Company] = []
    var companyPriceInfo = Daily()
    @IBOutlet weak var backButtonItem: UIBarButtonItem!
    let yesterday = Date().dayBefore
    
    
    @IBOutlet weak var addButtonItem: UIBarButtonItem!
    var passedCompany: Company!
    


    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        navigationController?.navigationBar.barTintColor = returnHomeButton.backgroundColor
        backButtonItem.tintColor = .white
        addButtonItem.tintColor = .white
        MyStocksViewController.orangeColor = returnHomeButton.backgroundColor
        
                
        //this will check to see if an empty ticker was not passed and that a ticker thats not already in the list is not added again
        if passedCompany != nil {
            if (!myStocks.contains(Company(ticker: passedCompany.ticker, name: passedCompany.name, market: passedCompany.market, locale: passedCompany.locale, currency: passedCompany.currency, active: passedCompany.active, primaryExch: passedCompany.primaryExch, updated: passedCompany.updated))) {
                myStocks.append(Company(ticker: passedCompany.ticker, name: passedCompany.name, market: passedCompany.market, locale: passedCompany.locale, currency: passedCompany.currency, active: passedCompany.active, primaryExch: passedCompany.primaryExch, updated: passedCompany.updated))
                saveData()
            }
        }
        self.tableView.reloadData()


    }
    
    func saveData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("myStocks").appendingPathExtension("json")
        let jsonEncoder = JSONEncoder()
        let data = try? jsonEncoder.encode(myStocks)
        
        do {
            try data?.write(to: documentURL, options: .noFileProtection)
        } catch {
            print("Saving the data did not work")
        }
    }
    
    func loadData() {
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentURL = directoryURL.appendingPathComponent("myStocks").appendingPathExtension("json")
        guard let data = try? Data(contentsOf: documentURL) else {
            print("Loading the data did not work")
            return
        }
        let jsonDecoder = JSONDecoder()

        do {
            try myStocks = try jsonDecoder.decode(Array<Company>.self, from: data)
            tableView.reloadData()
        } catch {
            print("decoding the data did not work")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.companyInfo = myStocks[selectedIndexPath.row]

            ViewController.dailyURL = "https://api.polygon.io/v1/open-close/" + myStocks[selectedIndexPath.row].ticker + "/" + yesterday + "?apiKey=eacX00iD4hFfv7Q0ZiOZKMxjqtyyOO2I"
            companyPriceInfo.getData {
                
            }
            destination.dailyInfo = companyPriceInfo
            destination.ticker = myStocks[selectedIndexPath.row].ticker
            destination.cameFromDetail = false

            
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    


}

extension MyStocksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = myStocks[indexPath.row].name
        return cell
    }
    
    
}
