//
//  FetchOptionViewController.swift
//  FourWaysOfCreatingFetchRequest
//
//  Created by Mazharul Huq on 1/25/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit
import CoreData

class FetchOptionViewController: UITableViewController {
    var coreDataStack:CoreDataStack!
    var countries:[Country] = []
    var fetchRequest:NSFetchRequest<Country>!
    var fetchString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataStack = CoreDataStack(modelName: "CountryList")
        
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        getFetchRequest(option: indexPath.row)
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "displayViewController") as! DisplayViewController
        vc.coreDataStack = self.coreDataStack
        vc.fetchRequest = self.fetchRequest
        vc.fetchString = self.fetchString
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getFetchRequest(option:Int){
        switch option{
        case 0:
            //Using designated initializer
            self.fetchRequest = NSFetchRequest()
            let entity = NSEntityDescription.entity(forEntityName: "Country", in: coreDataStack.managedContext)
            fetchRequest.entity = entity
            fetchString = """
             let fetchRequest = NSFetchRequest()
             let entity = NSEntityDescription.entity(forEntityName:
                      \"Country\", in: coreDataStack.managedContext)
            fetchRequest.entity = entity
            """
            print("Designated")
        case 1:
            //Using convenience initializer
            self.fetchRequest =  NSFetchRequest<Country>(entityName:"Country")
            self.fetchString = """
            let fetchRequest = NSFetchRequest<Country>(entityName:\"Country\")
            """
            print("Convenience")
        case 2:
            //Using fetchRequest() method of subclass
            self.fetchRequest = Country.fetchRequest()
            self.fetchString = """
            let fetchRequest:NSFetchRequest<Country> = Country.fetchRequest()
            """
            print("Subclass")
        case 3:
            //Using fetch template in data model
            guard let model = coreDataStack.managedContext.persistentStoreCoordinator?.managedObjectModel,
                let fetchRequest = model.fetchRequestTemplate(forName: "SimpleFetchRequest") as? NSFetchRequest<Country> else{
                        return
            }
            self.fetchRequest = fetchRequest
            self.fetchString = """
            guard let model = coreDataStack.managedContext
            .persistentStoreCoordinator?.managedObjectModel,
            let fetchRequest = model.fetchRequestTemplate(forName: "SimpleFetchRequest") as? NSFetchRequest<Country> else{
            return
            }
            """
            print("Data model")
        default:
            break
        }
        
    }
    

    
}
