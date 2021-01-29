//
//  DatePickerViewController.swift
//  DevChallenge
//
//  Created by Lynk on 1/29/21.
//

import UIKit

protocol DatePickerViewControllerDelegate: AnyObject {
    func setDate(date:Date)
}


class DatePickerViewController: UIViewController {
    
    let datePickerView = DatePickerView()
    weak var delegate: DatePickerViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(datePickerView)
        datePickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardNotifications()
    }
  
    private func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            datePickerView.frame.origin.y = 0.0 - keyboardSize.height
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        datePickerView.frame.origin.y = 0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}



extension DatePickerViewController: DatePickerViewDelegate {
    func tappedOutside(date:Date) {
        delegate?.setDate(date: date)
        dismiss(animated: true, completion: nil)
    }
    
}


