//
//  UIResponser+Extension.swift
//  Tip-Calculator
//
//  Created by berfin doksöz on 15.08.2023.
//

import UIKit

extension UIResponder {
    
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
    
}
