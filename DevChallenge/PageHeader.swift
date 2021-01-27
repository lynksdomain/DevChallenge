//
//  PageHeader.swift
//  DevChallenge
//
//  Created by Lynk on 1/27/21.
//

import UIKit

class PageHeader: UIView {
    
   private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.text = "Projects"
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = ColorGuide.bgWhite
        setUp()
        titleConstraints()
    }
    
    private func setUp() {
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
    }
    
    private func titleConstraints() {
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}
