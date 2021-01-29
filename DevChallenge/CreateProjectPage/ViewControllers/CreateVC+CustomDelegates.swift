//
//  CreateVC+CustomDelegates.swift
//  DevChallenge
//
//  Created by Lynk on 1/29/21.
//

import UIKit


extension CreateProjectViewController: DatePickerViewControllerDelegate {
    func setDate(date: Date) {
        createProjectView?.updateDateButton(date: date)
    }
}


extension CreateProjectViewController: CreateProjectViewDelegate {
    func dismissPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func savePressed(title: String, description: String, header: UIImage?, color: UIColor?,date:Date) {
        store.saveProject(title: title, description: description, header: header, color: color, date: date) { [weak self] result in
            switch result {
            case .success():
                self?.delegate?.reloadList()
                self?.dismiss(animated: true, completion: nil)
            case let .failure(error):
                print(error)
            }
        }
        
        
    }
    
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

}
