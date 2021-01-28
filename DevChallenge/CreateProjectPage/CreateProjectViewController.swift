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
        createProjectView?.delegate = self
        createProjectView?.setColorPickerDataSource(dataSource: self)
        createProjectView?.setColorPickerDelegateFlowLayout(delegate: self)
    }
}



extension CreateProjectViewController: CreateProjectViewDelegate {
    
    func uploadHeaderPressed() {
        print("header presed")
    }
    
    func datePressed() {
        print("date pressed")
    }
    
    func savePressed() {
        print("save pressed")
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
