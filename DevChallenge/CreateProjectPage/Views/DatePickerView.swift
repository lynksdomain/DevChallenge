//
//  DatePickerView.swift
//  DevChallenge
//
//  Created by Lynk on 1/29/21.
//

import UIKit

protocol DatePickerViewDelegate: AnyObject {
    func tappedOutside(date:Date)
}

class DatePickerView: UIView {
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .white
        datePicker.layerStyle(borderWidth: 0)
        datePicker.layer.masksToBounds = true
        return datePicker
    }()
    
    lazy var tap = UITapGestureRecognizer(target: self, action: #selector(tappedOutside))
    weak var delegate: DatePickerViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        setUp()
        datePickerConstraints()
    }
    
    func setUp() {
        addBlur()
        let view = UIView(frame: self.frame)
        view.backgroundColor = .clear
        addSubview(view)
        view.addGestureRecognizer(tap)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        addSubview(datePicker)
    }
    
    func datePickerConstraints() {
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            datePicker.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9)
        ])
    }
    

    
    
    
    @objc func tappedOutside(){
        delegate?.tappedOutside(date: datePicker.date)
    }
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
 
}
