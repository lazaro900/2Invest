//
//  ViewController.swift
//  2Invest
//
//  Created by Lazaro Alvelaez on 12/1/20.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    var companies = Companies()
    var companyPriceInfo = Daily()
    let yesterday = Date().dayBefore
    @IBOutlet weak var toolBar: UIToolbar!
    

    
    static var dailyURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        toolBar.barTintColor = MyStocksViewController.orangeColor
        
        companies.getData {
            DispatchQueue.main.async {
                self.navigationItem.title = "Page \(Companies.page) of \(self.companies.count / 50 + 1)"
                self.tableView.reloadData()
            }
        }

    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.companyInfo = companies.companyArray[selectedIndexPath.row]
            ViewController.dailyURL = "https://api.polygon.io/v1/open-close/" + companies.companyArray[selectedIndexPath.row].ticker + "/" + yesterday + "?apiKey=eacX00iD4hFfv7Q0ZiOZKMxjqtyyOO2I"
            companyPriceInfo.getData {
                
            }
            destination.dailyInfo = companyPriceInfo
            destination.ticker = companies.companyArray[selectedIndexPath.row].ticker


            
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
    
    @IBAction func pageTextFieldTriggered(_ sender: UITextField) {
        if sender.text != "" {
            
            guard let pg = Int(sender.text!) else {
                //user entered a company name, not a page number
                Companies.comp = sender.text!
                companies.getData {
                    DispatchQueue.main.async {
                        self.navigationItem.title = "Page \(Companies.page) of \(self.companies.count / 50 + 1)"
                        self.tableView.reloadData()
                    }
                }
                return
            }
            
            Companies.page = Int(sender.text!)!
            companies.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Page \(Companies.page) of \(self.companies.count / 50 + 1)"
                    self.tableView.reloadData()
                }
            }
        }
    }
    @IBAction func leftPageClicked(_ sender: UIBarButtonItem) {
        if Companies.page != 1 {
            Companies.page -= 1
            companies.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Page \(Companies.page) of \(self.companies.count / 50 + 1)"
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    @IBAction func rightPageClicked(_ sender: UIBarButtonItem) {
        if Companies.page != self.companies.count / 50 + 1 {
            Companies.page += 1
            companies.getData {
                DispatchQueue.main.async {
                    self.navigationItem.title = "Page \(Companies.page) of \(self.companies.count / 50 + 1)"
                    self.tableView.reloadData()
                }
            }
        }
    }
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.companyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = companies.companyArray[indexPath.row].name
        return cell
    }
    
    
}

