//
//  ProjectStore.swift
//  DevChallenge
//
//  Created by Lynk on 1/29/21.
//

import UIKit
import CoreData


class ProjectStore: NSObject {
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DevChallenge")

        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    
    
    func saveProject(title:String,description:String,header:UIImage?,color:UIColor?, date: Date, completion: @escaping (Result<Void,Error>) -> Void) {
       
        guard let entity = NSEntityDescription.entity(forEntityName: "Project", in: persistentContainer.viewContext) else { return }
        let project = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
        
        project.setValue(title, forKey: "title")
        project.setValue(description, forKey: "projectDescription")
        project.setValue(date, forKey: "date")
        
        if let header = header,
           let headerData = header.jpegData(compressionQuality: 1.0){
            project.setValue(headerData, forKey: "header")
        } else if let color = color {
            project.setValue(color.encode(), forKey: "headerColor")
        }
        
        let viewContext = persistentContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
                completion(.success(()))
            } catch {
                let nserror = error as NSError
                completion(.failure(nserror))
            }
        }
    }
    
    func fetchProjects(completion: @escaping ([NSManagedObject]?,Error?) -> Void) {
        let request = NSFetchRequest<NSManagedObject>(entityName: "Project")
        do {
            let projects = try persistentContainer.viewContext.fetch(request)
            completion(projects,nil)
         } catch let error as NSError {
           completion(nil,error)
         }
    }
}
