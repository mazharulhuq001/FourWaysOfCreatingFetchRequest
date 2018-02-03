//
//  DisplayViewController.swift
//  FourWaysOfCreatingFetchRequest
//
//  Created by Mazharul Huq on 1/25/18.
//  Copyright © 2018 Mazharul Huq. All rights reserved.
//

import UIKit
import CoreData

class DisplayViewController: UIViewController {
    
    @IBOutlet var usingTextView: UITextView!
    
    @IBOutlet var displayTextView: UITextView!
    
    var fetchRequest:NSFetchRequest<Country>!
    var fetchString = ""
    var coreDataStack:CoreDataStack!
    var countries:[Country] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.usingTextView.text = self.fetchString
        self.displayTextView.text = ""
        do{
            let results = try coreDataStack.managedContext.fetch(self.fetchRequest)
            countries = results
            let string = NSMutableAttributedString()
            for i in 0..<countries.count{
               string.append(getAttributedString(country: countries[i]))
            }
            self.displayTextView.attributedText = string
        }
        catch
            let nserror  as NSError{
                print("Could not save \(nserror),(nserror.userInfo)")
        }
    }

    func getAttributedString(country:Country)->NSMutableAttributedString{
        let topString = country.name! + "  Capital:" + country.capital! + "\n"
        let bottomString = "Area: \(Int(Double(country.area)/1000)) (1000 sq. mi.) Population:" + "\(country.population) millions\n\n"
        let topAttributed = NSMutableAttributedString(string: topString, attributes:[.font:UIFont(name:"Arial", size:20)!,.foregroundColor: UIColor(red: 0.80, green: 0.0, blue: 0.3, alpha: 1.0)])
        let bottomAttributed = NSMutableAttributedString(string: bottomString, attributes:[.font:UIFont(name:"Arial", size:15)!])
        
        let result = NSMutableAttributedString()
        result.append(topAttributed)
        result.append(bottomAttributed)
        return result
        
    }
}
