//
//  ProjectsViewController.swift
//  DevChallenge
//
//  Created by Lynk on 1/26/21.
//

import UIKit
import CoreData

class ProjectsViewController: UIViewController {

    let projectsView = ProjectsView()
    var store: ProjectStore!
    var projects = [NSManagedObject]() {
        didSet {
            projectsView.reload()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(projectsView)
        projectsView.setDeleagate(delegate: self)
        projectsView.setDataSource(dataSource: self)
        fetch()
    }
   
    func fetch() {
        store.fetchProjects { [weak self] (projects, error) in
            if let projects = projects {
                self?.projects = projects
            } else if let error = error {
                print(error)
            }
        }
    }
}


extension ProjectsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == projects.count {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "createCell", for: indexPath) as? CreateProjectCell else { return UITableViewCell() }
        cell.delegate = self
        return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as? ProjectCell else { return UITableViewCell() }
            let project = projects[indexPath.row]
            cell.titleLabel.text = project.value(forKey: "title") as? String
            guard let date = project.value(forKey: "date") as? Date else { return cell}
            cell.dateLabel.text = date.formattedDate()
            
            if let headerdata = project.value(forKey: "header") as? Data,
               let header = UIImage(data: headerdata) {
                cell.header.image = header
                cell.header.clipsToBounds = true
                cell.header.contentMode = .scaleAspectFill
            } else if let colorData = project.value(forKey: "headerColor") as? Data,
                      let color = UIColor.color(data: colorData) {
                cell.header.backgroundColor = color
            }
            
            
            return cell
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != projects.count else { return }
        let project = projects[indexPath.row]
        guard let date = project.value(forKey: "date") as? Date,
              let title = project.value(forKey: "title") as? String,
              let description = project.value(forKey: "projectDescription") as? String else { return }
        let dateString = date.formattedDate()
        var image: UIImage?
        var headerColor: UIColor?
        if let headerdata = project.value(forKey: "header") as? Data,
           let header = UIImage(data: headerdata) {
            image = header
        } else if let colorData = project.value(forKey: "headerColor") as? Data,
                  let color = UIColor.color(data: colorData) {
            headerColor = color
        }
        let createViewController = CreateProjectViewController(type: .view)
        createViewController.setInfo(title: title, description: description, date: dateString, color: headerColor, header: image)
        createViewController.modalPresentationStyle = .overFullScreen
        createViewController.store = store
        present(createViewController, animated: true, completion: nil)
    }

}

extension ProjectsViewController: CreateProjectViewControllerDelegate {
    func reloadList() {
        fetch()
    }
}


extension ProjectsViewController: CreateProjectCellDelegate {
    func addButtonPressed() {
        let createViewController = CreateProjectViewController(type: .create)
        createViewController.modalPresentationStyle = .overFullScreen
        createViewController.store = store
        createViewController.delegate = self
        present(createViewController, animated: true, completion: nil)
    }
}
