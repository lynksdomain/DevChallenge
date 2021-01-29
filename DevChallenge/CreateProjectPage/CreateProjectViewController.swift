//
//  CreateProjectViewController.swift
//  DevChallenge
//
//  Created by Lynk on 1/27/21.
//

import UIKit

class CreateProjectViewController: UIViewController {
    
    var createProjectView: CreateProjectView?

    init(type:CreateProjectViewType) {
        super.init(nibName: nil, bundle: nil)
        createProjectView = CreateProjectView(type: type)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createProjectView ?? CreateProjectView(type: .create))
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    
    private func setDelegates() {
        createProjectView?.delegate = self
        createProjectView?.setTextDelegates(viewController: self)
        createProjectView?.setColorPickerDataSource(dataSource: self)
        createProjectView?.setColorPickerDelegateFlowLayout(delegate: self)
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
            createProjectView?.frame.origin.y = 0.0 - keyboardSize.height
            UIView.animate(withDuration: duration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        createProjectView?.frame.origin.y = 0
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}



extension CreateProjectViewController: CreateProjectViewDelegate {
    
    func uploadHeaderPressed() {
        let gallery = UIImagePickerController()
        gallery.sourceType = .photoLibrary
        gallery.delegate = self
        present(gallery, animated: true, completion: nil)
    }
    
    func datePressed() {
        let dateViewController = DatePickerViewController()
        dateViewController.delegate = self
        dateViewController.modalPresentationStyle = .overCurrentContext
        dateViewController.modalTransitionStyle = .crossDissolve
        present(dateViewController, animated: true, completion: nil)
    }
    
    func savePressed() {
        print("save pressed")
    }
    
    
}


extension CreateProjectViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            createProjectView?.updateProjectHeader(image: pickedImage)
            createProjectView?.deselectColors()
            }
        dismiss(animated: true, completion: nil)
    }
}

extension CreateProjectViewController: DatePickerViewControllerDelegate {
    func setDate(date: Date) {
        createProjectView?.updateDateButton(date: date)
    }
}


extension CreateProjectViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


extension CreateProjectViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? PlacerholderTextView else { return }
        textView.placeholder.isHidden = !textView.text.isEmpty
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}


extension CreateProjectViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ColorGuide.colorPickerColors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCell else { return UICollectionViewCell() }
        cell.setColor(color: ColorGuide.colorPickerColors[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = ColorPickerValues.inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + ColorPickerValues.minInteritemSpacing * CGFloat(ColorGuide.colorPickerColors.count - 1)
        let width = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(ColorGuide.colorPickerColors.count))
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return ColorPickerValues.minLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return ColorPickerValues.minInteritemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: ColorPickerValues.inset, left: ColorPickerValues.inset, bottom: ColorPickerValues.inset, right: ColorPickerValues.inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        createProjectView?.setProjectHeaderColor(row: indexPath.row)
        
    }
}

struct ColorPickerValues {
    private init() {}
    static let inset: CGFloat = 10
    static let minLineSpacing: CGFloat = 20
    static let minInteritemSpacing: CGFloat = 20
}
