//
//  SurveyViewController.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/27/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    
    //I'm making this a forced optional because in the future, we may want a different view controller to manipulate these questions before SurveyViewController is initialized. Having it be a forced optional allows us to leave it undefined in the initializer of this class, but the onus is still on us to make sure it's defined by the time that the code needs it.
    
    var survey : Survey! = Survey(withQuestions: ["Test 1", "Test 2", "Test 3", "Test 4", "Test 5", "Test 6", "Test 7", "Test 8", "Test 9", "Test 10"])
    
    @IBOutlet weak var surveyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register the cell nib type with the table, so it can load cells correctly.
        let cellNib = UINib(nibName: "SurveyTableViewCell", bundle: nil)
        surveyTableView.register(cellNib, forCellReuseIdentifier: "SurveyTableViewCell")
        
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
        guard let cell = surveyTableView.dequeueReusableCell(withIdentifier: "SurveyTableViewCell", for: indexPath) as? SurveyTableViewCell else {
            fatalError("Error: SurveyTableViewCell cast failed.")
        }
        
        //The question number is equal to the indexPath row plus one.
        cell.questionNumberLabel.text = String(indexPath.row + 1)
        
        //The cell should also be able to keep track of which cell it is.
        cell.cellIndex = indexPath.row
        
        //The question text should be what is stored in the surveyQuestions array in the indexPath.row-th element.
        cell.questionContentLabel.text = survey.questions[indexPath.row]
        
        //To maintain consistency, the cell's selected segment should correspond to the stored data. Otherwise, it'll change as we scroll, due to how the cells are reused.
        cell.segmentedControl.selectedSegmentIndex = survey.answers[indexPath.row]
        
        //Finally, the cell should know this controller.
        cell.dataSourceController = self
        
        //Return the cell.
        return cell
    }
    
    //This function will be called by a cell when it the user taps on a new segment in its segmented control.
    func surveyCellDidSelectNewSegment(cellIndex: Int, value: Int){
        //Just update the value in the answer array for now.
        survey.answers[cellIndex] = value
    }
    
}
