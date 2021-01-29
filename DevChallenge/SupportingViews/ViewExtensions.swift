//
//  ViewExtensions.swift
//  DevChallenge
//
//  Created by Lynk on 1/29/21.
//

import UIKit


extension UITextField {
    func setPadding() {
        let lPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        let rPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.size.height))
        self.leftView = lPadding
        self.leftViewMode = .always
        self.rightView = rPadding
        self.rightViewMode = .always
    }
}


extension UIView {
    func layerStyle(borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = ColorGuide.borderGray.cgColor
        self.layer.cornerRadius = 10
        self.layer.cornerCurve = .continuous
    }
}

extension Date {
    func formattedDate() -> String{
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .ordinal
        let formattedDay = numberFormat.string(from: NSNumber(value: day))
        let monthFormat = DateFormatter()
        monthFormat.dateFormat = "MMM"
        let month = monthFormat.string(from: self)
        let timeFormat = DateFormatter()
        timeFormat.dateFormat = "h:mm a"
        let time = timeFormat.string(from: self)
        guard let formatDay = formattedDay else { return "" }
        return "\(month) \(formatDay), \(time)"
    }
}

extension UIColor {

     class func color(data:Data) -> UIColor? {
          return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
     }

     func encode() -> Data? {
          return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
     }
}


class PlacerholderTextView: UITextView {
    var placeholder = UILabel()
    
    func setPlaceholder() {
        placeholder.text = "Type Here"
        self.addSubview(placeholder)
        placeholder.font = UIFont.systemFont(ofSize: 14)
        placeholder.sizeToFit()
        placeholder.frame.origin = CGPoint(x: 10, y: (self.font?.pointSize)! / 2 + 3)
        placeholder.textColor = UIColor.placeholderText
        placeholder.isHidden = !self.text.isEmpty
    }
}
