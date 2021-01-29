//
//  ProjectsView.swift
//  DevChallenge
//
//  Created by Lynk on 1/26/21.
//

import UIKit


class ProjectsView: UIView {
        
    private lazy var projectTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CreateProjectCell.self, forCellReuseIdentifier: "createCell")
        tableView.register(ProjectCell.self, forCellReuseIdentifier: "projectCell")
        tableView.backgroundColor = ColorGuide.bgWhite
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = ColorGuide.bgWhite
        setUp()
        tableViewConstraints()
    }
    
    private func setUp() {
        projectTableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(projectTableView)
    }
    
    
    private func tableViewConstraints() {
        NSLayoutConstraint.activate([
            projectTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            projectTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            projectTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            projectTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func reload() {
        projectTableView.reloadData()
    }
}


// helper methods
extension ProjectsView {
    func setDeleagate(delegate: UITableViewDelegate) {
        projectTableView.delegate = delegate
    }
    
    func setDataSource(dataSource: UITableViewDataSource) {
        projectTableView.dataSource = dataSource
    }
}
