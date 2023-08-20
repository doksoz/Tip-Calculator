//
//  Tip_CalculatorSnapshotTesta.swift
//  Tip-CalculatorTests
//
//  Created by berfin doksöz on 15.08.2023.
//

import Foundation
import SnapshotTesting
import XCTest
@testable import Tip_Calculator
    
final class Tip_CalculatorSnapshotTests: XCTestCase{
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        //given
        let size = CGSize(width: screenWidth, height: 48)
        //when
        let view = LogoView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialResultView() {
        //given
        let size = CGSize(width: screenWidth, height: 224)
        //when
        let view = ResultView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testResultViewWithValue() {
        //given
        let size = CGSize(width: screenWidth, height: 224)
        let result = Result(
            amountPerPerson: 100.25,
            totalBill: 45,
            totalTip: 60)
        //when
        let view = ResultView()
        view.configure(result: result)
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialBillInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testBillInputViewWithValue() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = BillInputView()
        let textField = view.allSubViewsOf(type: UITextField.self).first
        textField?.text = "500"
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testInitialTipInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testTipInputViewWithSelection() {
        //given
        let size = CGSize(width: screenWidth, height: 56+56+16)
        //when
        let view = TipInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testSpkitInputView() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
    func testSplitInputViewWithSelection() {
        //given
        let size = CGSize(width: screenWidth, height: 56)
        //when
        let view = SplitInputView()
        let button = view.allSubViewsOf(type: UIButton.self).first
        button?.sendActions(for: .touchUpInside)
        //then
        assertSnapshot(matching: view, as: .image(size: size))
    }
    
}

extension UIView {
    
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
            all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
    
  }
