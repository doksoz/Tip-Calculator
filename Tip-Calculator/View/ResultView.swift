//
//  ResultView.swift
//  Tip-Calculator
//
//  Created by berfin doksöz on 15.08.2023.
//

import UIKit

class ResultView: UIView {
    
    private let headerLabel: UILabel = {
        LabelFactory.build(
            text: "Total p/person",
            font: ThemeFont.demibold(ofSize: 18))
    }()
    
    private let amountPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(
            string: "$0",
            attributes: [
                .font: ThemeFont.bold(ofSize: 48)
            ])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        label.attributedText = text
        return label
    }()
    
    private let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.seperator
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            headerLabel,
            amountPersonLabel,
            horizontalLineView,
            buildSpacerView(height: 0),
            hStackView
        ])
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    private let totalBillView: AmountView = {
        let view = AmountView(title: "Total bill", textAlignment: .left)
        return view
    }()
    
    private let totalTipView: AmountView = {
        let view = AmountView(title: "Total tip", textAlignment: .right)
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
           totalBillView,
           UIView(),
           totalTipView
        ])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: Result) {
        let text = NSMutableAttributedString(
            string: result.amountPerPerson.currencyFormatted,
            attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([
            .font: ThemeFont.bold(ofSize: 24)
        ], range: NSMakeRange(0, 1))
        amountPersonLabel.attributedText = text
        
        totalBillView.configure(amount: result.totalBill)
        
        totalTipView.configure(amount: result.totalTip)
    }
    
    private func layout(){
        backgroundColor = .white
        addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        horizontalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
      
        addShadow(offSet: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.2)
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
    
}
