//
//  SettingsViewController.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 4/5/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    @IBOutlet weak var colorHueView: UIView!
    @IBOutlet weak var colorViewSlider: UISlider!
    
    @IBOutlet weak var deleteAllDataButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        colorViewSlider.value = UserDefaults.standard.float(forKey: "savedColorHue")
        colorHueView.backgroundColor = Constants.userLineColor
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        UserDefaults.standard.set(colorViewSlider.value, forKey: "savedColorHue")
        
    }
    
    @IBAction func deleteAllDataButtonPressed(_ sender: Any) {
        
        //First, we're going to want to confirm that the user definitely wants to do this. This is a destructive action, after all.
        
        let alert = UIAlertController(title: "Last Warning: Are You Sure?", message: "This action will delete ALL stored data. You will not be able to recover it. Are you sure you want to delete all stored data?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Delete", comment: "Destructive action"), style: .destructive, handler: { (_) in
            //Now let's delete the data (in this handler, which only gets called if the user presses the delete UIAlertAction)
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GraphDataPoint")
            
            //If we want to add restrictions to what we want to delete, we'd change request.predicate now. For this method, that's not what we want.
            
            request.returnsObjectsAsFaults = false
            
            do {
            //Now, we'll do things in here with result... which is to delete everything.
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
                try Constants.moc.persistentStoreCoordinator?.execute(deleteRequest, with: Constants.moc)
                
                try Constants.moc.save()
                
                
                //We want to try doing things to the parent Graph View Controller before we see it. Let's do that stuff here.
                //This line gets the previous view controller and fails gracefully if it can't, or fails horribly if the SettingsViewController is the first in the navigation controller.
                guard let graphVC = self.navigationController?.viewControllers[(self.navigationController?.viewControllers.count ?? 2) - 2] as? GraphViewController else {
                    self.presentDialogBox(withTitle: "Error", withMessage: "There was a problem refreshing the graph. Please try restarting the app.")
                    return
                }
                
                
                
                //Now the chart should be updated for our return to the graph. Now let's dismiss the settings VC.
                
                self.navigationController?.popViewController(animated: true)
                
                //graphVC.chartEntries.removeAll()
                //graphVC.updateChart()
                
                graphVC.presentDialogBox(withTitle: "Success", withMessage: "All data deleted successfully.")
                
            } catch {
                self.presentDialogBox(withTitle: "Error", withMessage: "There was a problem deleting all of the data: \(error)")
            }
            
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Never Mind"), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func colorSliderValueChanged(_ sender: UISlider) {
        
        colorHueView.backgroundColor = UIColor(hue: CGFloat(colorViewSlider.value), saturation: 1.0, brightness: 1.0, alpha: 1.0)
        
    }
    
    
    
    
}
