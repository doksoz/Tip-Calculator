//
//  HeaderView.swift
//  Tip-Calculator
//
//  Created by berfin doksöz on 15.08.2023.
//

import UIKit

class HeaderView: UIView{
    
    private let topLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.bold(ofSize: 18))
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.regular(ofSize: 16))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            topSpacerView,
            topLabel,
            bottomLabel,
            bottomSpacerView
        ])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = -4
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout(){
       addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.equalTo(bottomSpacerView)
        }
    }
    
    func configure(topText: String, bottomText: String){
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}
