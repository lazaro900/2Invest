//
//  Daily.swift
//  2Invest
//
//  Created by Lazaro Alvelaez on 12/3/20.
//

import Foundation

class Daily {
    
    struct Returned: Codable {
        var open: Double
        var high: Double
        var low: Double
        var close: Double
        var volume: Int
        var afterHours: Double
        var preMarket: Double
    }
    
    var company: Returned!
    
    func getData(completed: @escaping () -> ()) {
        //create url
        guard let url = URL(string: ViewController.dailyURL) else {
            print("Error: Could not create a URL from \(ViewController.dailyURL)")
            return
        }
        
        //create session
        let session = URLSession.shared
        
        //get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            do {
                let returned = try JSONDecoder().decode(Returned.self, from: data!)
                print(returned)
                self.company = returned
                self.company.open = (returned.open == nil ? 0.0 : returned.open)
                self.company.high = returned.high
                self.company.low = returned.low
                self.company.close = returned.close
                self.company.volume = returned.volume
                self.company.afterHours = returned.afterHours
                self.company.preMarket = returned.preMarket
                

            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
            print("This is what we got from web. \(url)")
            completed()
            
        }
        task.resume()
    }
    
}
