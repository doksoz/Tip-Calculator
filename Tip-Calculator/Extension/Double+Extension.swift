//
//  Double+Extension.swift
//  Tip-Calculator
//
//  Created by berfin doksöz on 15.08.2023.
//

import Foundation

extension Double {
    var currencyFormatted: String {
        var isWholeNumber: Bool {
            isZero ? true : !isNormal ? false : self == rounded()
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = isWholeNumber ? 0 : 2
        return formatter.string(for: self) ?? ""
    }
}
