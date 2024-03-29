//
//  Order.swift
//  CupcakeCorner
//
//  Created by Chris Hunter-Brown on 20/02/2024.
//

import Foundation
import SwiftUI

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }

    init() {
        let defaults = UserDefaults.standard
        name = defaults.string(forKey: "name") ?? ""
        streetAddress = defaults.string(forKey: "streetAddress") ?? ""
        city = defaults.string(forKey: "city") ?? ""
        zip = defaults.string(forKey: "zip") ?? ""
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name: String {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "name")
        }
    }
    var streetAddress: String {
        didSet {
            UserDefaults.standard.set(streetAddress, forKey: "streetAddress")
        }
    }
    var city: String {
        didSet {
            UserDefaults.standard.set(city, forKey: "city")
        }
    }
    var zip: String {
        didSet {
            UserDefaults.standard.set(zip, forKey: "zip")
        }
    }

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }

    var cost: Double {
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        if extraFrosting {
            cost += Double(quantity)
        }

        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
