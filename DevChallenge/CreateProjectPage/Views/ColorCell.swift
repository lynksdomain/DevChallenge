//
//  ColorCell.swift
//  DevChallenge
//
//  Created by Lynk on 1/28/21.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    private lazy var colorCircle: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        addSubview(colorCircle)
        colorCircle.translatesAutoresizingMaskIntoConstraints = false
        colorCircleConstraints()
    }
    
    private func colorCircleConstraints() {
        NSLayoutConstraint.activate([
            colorCircle.topAnchor.constraint(equalTo: topAnchor),
            colorCircle.bottomAnchor.constraint(equalTo: bottomAnchor),
            colorCircle.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorCircle.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        colorCircle.layer.cornerRadius = colorCircle.frame.size.width/2
        colorCircle.layer.cornerCurve = .circular
    }
    
    func setColor(color: UIColor) {
        colorCircle.backgroundColor = color
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                colorCircle.layer.borderWidth = 1
                colorCircle.layer.borderColor = UIColor.black.cgColor
                colorCircle.image = UIImage(named: "check")
            } else {
                colorCircle.layer.borderWidth = 0
                colorCircle.image = nil
            }
        }
    }
}
