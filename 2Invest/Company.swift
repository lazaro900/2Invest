//
//  Company.swift
//  2Invest
//
//  Created by Lazaro Alvelaez on 12/1/20.
//

import Foundation

struct Company: Codable, Equatable {
    var ticker: String
    var name: String
    var market: String
    var locale: String
    var currency: String
    var active: Bool
    var primaryExch: String
    var updated: String
}
