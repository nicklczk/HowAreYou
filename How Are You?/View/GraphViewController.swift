//
//  GraphViewController.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/27/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit
import CoreData

class GraphViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //viewDidAppear is called whenever the view... appears (more precisely, when it appears, not before).
        
        //For now, this just prints out all of the graphDataPoints to the terminal.
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GraphDataPoint")
        //At this point, if we wanted to add extra conditions, we'd change request.predicate. For now, we don't.
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try Constants.moc.fetch(request) as! [NSManagedObject]
            //Now, we'll do things in here with result.
            for dataPoint in result {
                //The date needs to be handled in a special way, via a DateFormatter.
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                //If we care enough, we can eventually set .locale to change to the user's. That doesn't really matter right now, though.
                let dateString = dateFormatter.string(from: dataPoint.value(forKey: "date") as! Date)
                
                print("Title: \(dataPoint.value(forKey: "surveyTitle")!)")
                print("Date: \(dateString)")
                print("PHQ: \(dataPoint.value(forKey: "phq")!)")
                print("Notes: \(dataPoint.value(forKey: "notes")!)")
            }
            
            
        } catch {
            self.presentDialogBox(withTitle: "Error", withMessage: "Fetching data failed. Please try again.")
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
