//
//  UIView+Extension.swift
//  Tip-Calculator
//
//  Created by berfin doksöz on 15.08.2023.
//

import UIKit

extension UIView{
    func addShadow(offSet: CGSize, color: UIColor, radius: CGFloat, opacity: Float){
        layer.cornerRadius = radius
        layer.masksToBounds = false
        layer.shadowOffset = offSet
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColour = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColour
    }
    
    func addCornerRadius(radius: CGFloat){
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addRoundedCorners(corners: CACornerMask, radius: CGFloat){
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
}
