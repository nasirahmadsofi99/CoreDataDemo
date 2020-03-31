//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Deftsoft on 16/03/20.
//  Copyright © 2020 Deftsoft. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        deleteAllData()
        createData()
        retrieveData()
    }
    
    
  
    
    
    


}

extension ViewController {
    
    func getContext() -> NSManagedObjectContext {
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        return appdelegate!.persistentContainer.viewContext
    }
    
    func createData(){
        //        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        //        let managedContext = appdelegate.persistentContainer.viewContext
        let context = getContext()
        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: context)!
        for i in 1...3 {
            let user = NSManagedObject(entity: userEntity, insertInto: context)
            user.setValue("abc\(i)", forKey: "userName")
            user.setValue("abc\(i)@test.com", forKey: "email")
            user.setValue("abc\(i)", forKey: "password")
        }
        
        do {
            try context.save()
        }
        catch let error as NSError {
            print("Could not Save Data. \(error),\(error.userInfo)")
        }
        
    }
    
    func retrieveData() {
        let context = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                print(data.value(forKey:"userName" ) as! String)
                print(data.value(forKey: "password") as! String)
            }
            } catch {
                print("Failed to fetch data")
            }
        }
    func deleteAllData() {
       let context = getContext()
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    
    }



    
    

