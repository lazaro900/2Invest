//
//  Companies.swift
//  2Invest
//
//  Created by Lazaro Alvelaez on 12/1/20.
//

import Foundation

class Companies {
    private struct Returned: Codable {
        var page: Int
        var count: Int
        var tickers: [Company]
    }
    
    var count = 0
    static var page = 1
    static var comp = ""
    var isFetching = false
    var companyArray: [Company] = []
    
    func getData(completed: @escaping () -> ()) {
        
        guard !isFetching else {
            return
        }
        isFetching = true
        
        //create url
        var urlString = ""
        if Companies.comp == "" {
            urlString = "https://api.polygon.io/v2/reference/tickers?sort=ticker&perpage=50&page=\(Companies.page)&apiKey=eacX00iD4hFfv7Q0ZiOZKMxjqtyyOO2I"
        } else {
            
            urlString = "https://api.polygon.io/v2/reference/tickers?sort=ticker&search=\(Companies.comp)&perpage=50&page=1&apiKey=eacX00iD4hFfv7Q0ZiOZKMxjqtyyOO2I"
            
        }
        guard let url = URL(string: urlString) else {
            print("Error: Could not create a URL from \(urlString)")
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
                self.companyArray = returned.tickers
                self.count = returned.count
                Companies.page = returned.page
                Companies.comp = ""
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
            self.isFetching = false
            completed()
            
        }
        task.resume()
    }
    
    
}
