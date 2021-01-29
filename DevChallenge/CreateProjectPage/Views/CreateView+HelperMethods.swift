//
//  CreateView+HelperMethods.swift
//  DevChallenge
//
//  Created by Lynk on 1/29/21.
//

import UIKit


extension CreateProjectView {
    
    func updateDateButton(date:Date) {
        dateButton.setTitle(date.formattedDate(), for: .normal)
        chosenDate = date
    }
    
    func updateProjectHeader(image: UIImage) {
        projectHeaderImageView.image = image
    }
    
    func deselectColors() {
        guard let paths = colorPicker.indexPathsForSelectedItems else { return }
        paths.forEach {
            colorPicker.cellForItem(at: $0)?.isSelected = false
        }
        chosenHeaderColor = nil
    }
    
    func setColorPickerDataSource(dataSource:UICollectionViewDataSource) {
        colorPicker.dataSource = dataSource
    }
    
    func setColorPickerDelegateFlowLayout(delegate:UICollectionViewDelegateFlowLayout) {
        colorPicker.delegate = delegate
    }
    
    func setProjectHeaderColor(row:Int) {
        projectHeaderImageView.backgroundColor = ColorGuide.colorPickerColors[row]
        chosenHeaderColor = ColorGuide.colorPickerColors[row]
        projectHeaderImageView.image = nil
    }
    
    func setTextDelegates(viewController: UIViewController) {
        guard let delegate = viewController as? UITextFieldDelegate,
              let textViewDelegate = viewController as? UITextViewDelegate else { return }
        titleTextField.delegate = delegate
        descriptionTextView.delegate = textViewDelegate
    }
    
}
