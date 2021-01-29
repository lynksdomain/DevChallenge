//
//  ProjectCell.swift
//  DevChallenge
//
//  Created by Lynk on 1/29/21.
//

import UIKit

class ProjectCell: UITableViewCell {

    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layerStyle(borderWidth: 1.0)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = ColorGuide.dateOrange
        label.textAlignment = .right
        return label
    }()
    
    lazy var header: UIImageView = {
        let imageView = UIImageView()
        imageView.layerStyle(borderWidth: 0)
        return imageView
    }()
    
    lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
        cardViewConstraints()
        headerConstraints()
        infoConstraints()
        titleConstraints()
        dateConstraints()
    }
    
    
    private func setUp() {
        header.translatesAutoresizingMaskIntoConstraints = false
        infoView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        cardView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cardView)
        cardView.addSubview(header)
        cardView.addSubview(infoView)
        infoView.addSubview(titleLabel)
        infoView.addSubview(dateLabel)
    }
    
    private func cardViewConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func headerConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: cardView.topAnchor),
            header.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            header.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.8),
            header.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
        ])
    }
    
  
    private func infoConstraints() {
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: header.bottomAnchor),
            infoView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            infoView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            infoView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
        ])
    }
    
    private func titleConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor)
        ])
    }
    
    private func dateConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            dateLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor)
        ])
    }
    
    

}
