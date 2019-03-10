//
//  SurveyViewController.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/27/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit
import CoreData

class SurveyViewController: UIViewController {
    
    //I'm making this a forced optional because in the future, we may want a different view controller to manipulate these questions before SurveyViewController is initialized. Having it be a forced optional allows us to leave it undefined in the initializer of this class, but the onus is still on us to make sure it's defined by the time that the code needs it.
    
    var survey : Survey! = Survey(withTitle: "Test Survey", withQuestions: ["Test 1", "Test 2", "Test 3", "Test 4", "Test 5", "Test 6", "Test 7", "Test 8", "Test 9", "Test 10"])
    
    @IBOutlet weak var surveyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Change the answer strings for the 9th (0-indexed) survey question.
        survey.answerStrings[9] = ["Not Difficult", "Somewhat Difficult", "Very Difficult", "Extremely Difficult"]
        
        //Register the cell nib type with the table, so it can load cells correctly.
        let cellNib = UINib(nibName: "SurveyTableViewCell", bundle: nil)
        surveyTableView.register(cellNib, forCellReuseIdentifier: SurveyTableViewCell.reuseIdentifier)

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

extension SurveyViewController : UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //The number of rows in the table should correspond to the number of elements in the data source.
        return survey.questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Attempt to cast the cell to our custom type. It must work, or else.
        guard let cell = surveyTableView.dequeueReusableCell(withIdentifier: SurveyTableViewCell.reuseIdentifier, for: indexPath) as? SurveyTableViewCell else {
            fatalError("Error: SurveyTableViewCell cast failed.")
        }
        
        //The question number is equal to the indexPath row plus one.
        cell.questionNumberLabel.text = String(indexPath.row + 1)
        
        //The cell should also be able to keep track of which cell it is.
        cell.cellIndex = indexPath.row
        
        //The question text should be what is stored in the surveyQuestions array in the indexPath.row-th element.
        cell.questionContentLabel.text = survey.questions[indexPath.row]
        
        //Now, we will change the cell's segmented control based on the corresponding answerStrings array, if it's defined for this question.
        if (survey.answerStrings[indexPath.row] != nil){
            cell.segmentedControl.removeAllSegments()
            for i in 0..<survey.answerStrings[indexPath.row]!.count {
                cell.segmentedControl.insertSegment(withTitle: survey.answerStrings[indexPath.row]![i], at: i, animated: true)
            }
        }
        
        //To maintain consistency, the cell's selected segment should correspond to the stored data. Otherwise, it'll change as we scroll, due to how the cells are reused.
        cell.segmentedControl.selectedSegmentIndex = survey.answers[indexPath.row]
        
        //Finally, the cell should know this controller.
        cell.surveyViewController = self
        
        //Return the cell.
        return cell
    }
    
    //This sets the section title to what we want. Since we only have one section, this will serve as the header for the table, and will display the title.
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return survey.title
        //This produces a somewhat-underwhelming result, so in the future we may want to create a custom view to serve as the header view instead.
    }
    
    //Again, since we only have one section, we'll only have one footer.
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView : SurveyTableViewFooter = .fromNib()

        footerView.surveyViewController = self
                
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }
    
    //This function will be called by a cell when it the user taps on a new segment in its segmented control.
    func surveyCellDidSelectNewSegment(cellIndex: Int, value: Int){
        //Just update the value in the answer array for now.
        survey.answers[cellIndex] = value
    }
    
    //This function will be called when the submit button is pressed.
    func footerDidPressSubmitButton(){
        //This just prints a line to the terminal.
        NSLog("Submit button pressed.\n")
        
        //Now, before we save, let's try getting notes from our user. In the interest of speed I'll just do this in a UIAlertController.
        //We can change the method we get notes later, if we want.
        let alert = UIAlertController(title: "Notes", message: "Do you have any notes you'd like to record for today?", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Write your notes here..."
        }
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { (_) in
            
            //The user pressed OK; let's now save the point with Core Data.
            let entity = NSEntityDescription.entity(forEntityName: "GraphDataPoint", in: Constants.moc)!
            let graphDataPoint = NSManagedObject(entity: entity, insertInto: Constants.moc)
            
            //The survey's name is literally the title of the survey object.
            graphDataPoint.setValue(self.survey.title, forKey: "surveyTitle")
            //A Date() by default is just the current date.
            graphDataPoint.setValue(Date(), forKey: "date")
            //The summed answers is the PHQ.
            graphDataPoint.setValue(self.survey.answersSum, forKey: "phq")
            //Save the input from the textField we added as the "notes" data.
            graphDataPoint.setValue(alert.textFields![0].text, forKey: "notes")
            
            //Now, we actually need to explicitly save our new managed object by saving the managed object context.
            do {
                try Constants.moc.save()
            } catch {
                //If that failed, let's present a dialog box.
                self.presentDialogBox(withTitle: "Error", withMessage: "There was an error saving the survey results. Please try again.")
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        //If the user cancels, nothing will happen.
        
    }
    
}
