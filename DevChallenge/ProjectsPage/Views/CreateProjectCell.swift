//
//  CreateProjectCell.swift
//  DevChallenge
//
//  Created by Lynk on 1/27/21.
//

import UIKit


protocol CreateProjectCellDelegate: AnyObject {
    func addButtonPressed()
}

class CreateProjectCell: UITableViewCell {
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "circle"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layerStyle(borderWidth: 1.0)
        return view
    }()
    
    weak var delegate: CreateProjectCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    
    private func commonInit() {
        backgroundColor = ColorGuide.bgWhite
        selectionStyle = .none
        setUp()
        addCardViewConstraints()
        addButtonConstraints()
    }
    
    
    private func setUp() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
        cardView.addSubview(addButton)
    }
    
    private func addCardViewConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func addButtonConstraints() {
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            addButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 70),
            addButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
    private func styleCardView() {
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = ColorGuide.borderGray.cgColor
        cardView.layer.cornerRadius = 10
        cardView.layer.cornerCurve = .continuous
    }
    
    @objc private func addButtonPressed() {
        delegate?.addButtonPressed()
    }
    
}
