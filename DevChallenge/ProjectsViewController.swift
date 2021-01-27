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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "createCell", for: indexPath) as? CreateProjectCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return PageHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }

}


extension ProjectsViewController: CreateProjectCellDelegate {
    func addButtonPressed() {
        print("pressed")
    }
}
