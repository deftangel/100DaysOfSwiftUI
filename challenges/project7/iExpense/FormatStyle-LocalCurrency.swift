//
//  FormatStyle-LocalCurrency.swift
//  project7
//
//  Created by Chris Hunter-Brown on 29/04/2023.
//

import Foundation

extension FormatStyle where Self == FloatingPointFormatStyle<Double>.Currency {
    static var localCurrency: Self {
        .currency(code: Locale.current.currency?.identifier ?? "GBP")
    }
}
