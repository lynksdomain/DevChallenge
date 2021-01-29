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
        label.textAlignment = .center
        return label
    }()
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "dismiss"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.isHidden = true
        return button
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
    
     func setDismissButton() {
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dismissButton)
        dismissButton.isHidden = false
        NSLayoutConstraint.activate([
            dismissButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            dismissButton.heightAnchor.constraint(equalToConstant: 25),
            dismissButton.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func titleConstraints() {
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    
    
    func setTitleText(title:String) {
        self.title.text = title
    }

}
