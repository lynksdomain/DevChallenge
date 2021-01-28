//
//  CreateProjectView.swift
//  DevChallenge
//
//  Created by Lynk on 1/27/21.
//

import UIKit

enum CreateProjectViewType {
    case create,view
}

protocol CreateProjectViewDelegate: AnyObject {
    func uploadHeaderPressed()
    func datePressed()
    func savePressed()
}

class CreateProjectView: UIView {
    
    weak var delegate: CreateProjectViewDelegate?
    
    var type: CreateProjectViewType = .create
    
    lazy var header: PageHeader = {
        let header = PageHeader()
        header.setTitleText(title: "Create Project")
        return header
    }()
    
    lazy var projectHeaderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layerStyle(borderWidth: 1)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var uploadHeaderButton: UIButton = {
       let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "upload"), for: .normal)
        button.addTarget(self, action: #selector(uploadHeaderPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var uploadInstructions: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = ColorGuide.instructionsGray
        label.text = "Upload header image or choose color"
        label.textAlignment = .center
        return label
    }()
    
    lazy var colorPicker: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.isScrollEnabled = false
        collection.backgroundColor = .clear
        collection.register(ColorCell.self, forCellWithReuseIdentifier: "colorCell")
        collection.contentInsetAdjustmentBehavior = .always
        return collection
    }()
    
    lazy var dateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add date & time", for: .normal)
        button.addTarget(self, action: #selector(datePressed), for: .touchUpInside)
        button.layerStyle(borderWidth: 1)
        button.backgroundColor = .white
        button.setImage(UIImage(named: "date"), for: .normal)
        button.setTitleColor(ColorGuide.dateOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 11, left: 11, bottom: 13, right: 11)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.text = "Title"
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.layerStyle(borderWidth: 1)
        textField.placeholder = "Type Here"
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.setPadding()
        return textField
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        label.text = "Description"
        return label
    }()
    
    lazy var descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type Here"
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.setPadding()
        textField.layerStyle(borderWidth: 1)
        return textField
    }()
    
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = ColorGuide.buttonBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        button.layerStyle(borderWidth: 0)
        return button
    }()
    

    init(type: CreateProjectViewType) {
        super.init(frame: UIScreen.main.bounds)
        self.type = type
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = ColorGuide.bgWhite
        setUp()
        headerConstraints()
        projectHeaderConstraints()
        uploadInstructionsConstraints()
        uploadButtonConstraints()
        colorPickerConstraints()
        dateButtonConstraints()
        titleLabelConstraints()
        titleTextfieldConstraints()
        descriptionLabelConstraints()
        descriptionTextfieldConstraints()
        saveButtonConstraints()
    }
    
   
    
    private func setUp() {
        header.translatesAutoresizingMaskIntoConstraints = false
        projectHeaderImageView.translatesAutoresizingMaskIntoConstraints = false
        uploadHeaderButton.translatesAutoresizingMaskIntoConstraints = false
        uploadInstructions.translatesAutoresizingMaskIntoConstraints = false
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(header)
        addSubview(projectHeaderImageView)
        projectHeaderImageView.addSubview(uploadHeaderButton)
        projectHeaderImageView.addSubview(uploadInstructions)
        projectHeaderImageView.addSubview(colorPicker)
        addSubview(dateButton)
        addSubview(titleLabel)
        addSubview(titleTextField)
        addSubview(descriptionLabel)
        addSubview(descriptionTextField)
        addSubview(saveButton)
    }
    
    private func headerConstraints() {
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func projectHeaderConstraints() {
        NSLayoutConstraint.activate([
            projectHeaderImageView.topAnchor.constraint(equalTo: header.bottomAnchor),
            projectHeaderImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            projectHeaderImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            projectHeaderImageView.heightAnchor.constraint(equalToConstant: frame.height * 0.2)
        ])
    }
    
    private func uploadInstructionsConstraints() {
        NSLayoutConstraint.activate([
            uploadInstructions.centerXAnchor.constraint(equalTo: projectHeaderImageView.centerXAnchor),
            uploadInstructions.centerYAnchor.constraint(equalTo: projectHeaderImageView.centerYAnchor),
            uploadInstructions.leadingAnchor.constraint(equalTo: projectHeaderImageView.leadingAnchor),
            uploadInstructions.trailingAnchor.constraint(equalTo: projectHeaderImageView.trailingAnchor)
        ])
    }
    
    private func uploadButtonConstraints() {
        NSLayoutConstraint.activate([
            uploadHeaderButton.bottomAnchor.constraint(equalTo: uploadInstructions.topAnchor, constant: -8),
            uploadHeaderButton.heightAnchor.constraint(equalToConstant: 30),
            uploadHeaderButton.widthAnchor.constraint(equalToConstant: 30),
            uploadHeaderButton.centerXAnchor.constraint(equalTo: uploadInstructions.centerXAnchor)
        ])
    }
    
    private func colorPickerConstraints() {
        NSLayoutConstraint.activate([
            colorPicker.bottomAnchor.constraint(equalTo: projectHeaderImageView.bottomAnchor, constant: -8),
            colorPicker.heightAnchor.constraint(equalTo: projectHeaderImageView.heightAnchor, multiplier: 0.25),
            colorPicker.leadingAnchor.constraint(equalTo: projectHeaderImageView.leadingAnchor, constant: 16),
            colorPicker.trailingAnchor.constraint(equalTo: projectHeaderImageView.trailingAnchor, constant: -16)
        ])
    }
    
    private func dateButtonConstraints() {
        NSLayoutConstraint.activate([
            dateButton.topAnchor.constraint(equalTo: projectHeaderImageView.bottomAnchor, constant: 32),
            dateButton.heightAnchor.constraint(equalToConstant: 40),
            dateButton.leadingAnchor.constraint(equalTo: projectHeaderImageView.leadingAnchor),
            dateButton.trailingAnchor.constraint(equalTo: projectHeaderImageView.trailingAnchor)
        ])
    }
    
    private func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: dateButton.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: projectHeaderImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: projectHeaderImageView.trailingAnchor)
        ])
    }
    
    private func titleTextfieldConstraints() {
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            titleTextField.leadingAnchor.constraint(equalTo: projectHeaderImageView.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: projectHeaderImageView.trailingAnchor),
            titleTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func descriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 32),
            descriptionLabel.leadingAnchor.constraint(equalTo: projectHeaderImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: projectHeaderImageView.trailingAnchor)
        ])
    }
    
    private func descriptionTextfieldConstraints() {
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextField.leadingAnchor.constraint(equalTo: projectHeaderImageView.leadingAnchor),
            descriptionTextField.trailingAnchor.constraint(equalTo: projectHeaderImageView.trailingAnchor),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    private func saveButtonConstraints() {
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            saveButton.leadingAnchor.constraint(equalTo: projectHeaderImageView.leadingAnchor, constant: 8),
            saveButton.trailingAnchor.constraint(equalTo: projectHeaderImageView.trailingAnchor, constant: -8),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    

    private func styleCards() {
        dateButton.layerStyle(borderWidth: 1)
        projectHeaderImageView.layerStyle(borderWidth: 1)
        titleTextField.layerStyle(borderWidth: 1)
        descriptionTextField.layerStyle(borderWidth: 1)
        saveButton.layerStyle(borderWidth: 0)
    }
    
    @objc private func uploadHeaderPressed() {
        delegate?.uploadHeaderPressed()
    }
    
    @objc private func datePressed() {
        delegate?.datePressed()
    }
    
    @objc private func savePressed() {
        delegate?.savePressed()
    }
    
    
}

extension CreateProjectView {
    func setColorPickerDataSource(dataSource:UICollectionViewDataSource) {
        colorPicker.dataSource = dataSource
    }
    
    func setColorPickerDelegateFlowLayout(delegate:UICollectionViewDelegateFlowLayout) {
        colorPicker.delegate = delegate
    }
    
    func setProjectHeaderColor(row:Int) {
        projectHeaderImageView.backgroundColor = ColorGuide.colorPickerColors[row]
    }
}


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
