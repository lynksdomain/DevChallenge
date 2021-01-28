//
//  ProjectsViewController.swift
//  DevChallenge
//
//  Created by Lynk on 1/26/21.
//

import UIKit

class ProjectsViewController: UIViewController {

    let projectsView = ProjectsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(projectsView)
        projectsView.setDeleagate(delegate: self)
        projectsView.setDataSource(dataSource: self)
    }
}


extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "createCell", for: indexPath) as? CreateProjectCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return projectsView.frame.height * 0.2 + 16
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = PageHeader()
        header.setTitleText(title: "Projects")
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }

}


extension ProjectsViewController: CreateProjectCellDelegate {
    func addButtonPressed() {
        let createViewController = CreateProjectViewController(type: .create)
        createViewController.modalPresentationStyle = .overFullScreen
        present(createViewController, animated: true, completion: nil)
    }
}
