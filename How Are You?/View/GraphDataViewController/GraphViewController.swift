//
//  GraphViewController.swift
//  How Are You?
//
//  Created by Zaccari Silverman on 1/27/19.
//  Copyright © 2019 RCOS-HowAreYou. All rights reserved.
//

import UIKit
import Charts
import CoreData


enum DataFetchError : Error {
    case titleError
    case dateError
    case phqError
    case notesError
}

class GraphViewController: UIViewController {


    @IBOutlet weak var lineChartView: LineChartView!
    
    var chartOptions : [String]!
    
    /*This array will help us intermediately store chart data entries.*/
    var chartEntries = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chartSetup()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //This is called before the view appears, before viewWill Appear.

        //This needs to be cleared every time the view will appear.
        chartEntries.removeAll(keepingCapacity: true)
        testCoreData()
        updateChart()
  
    }
    
    func testCoreData(){
        //This is code meant to make sure I understand how Core Data works. It will be the basis of my actual data-fetching routine, but will eventually be deleted.
        
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
}

extension GraphViewController : ChartViewDelegate {
    
    func chartSetup(){
        lineChartView.drawMarkers = true
        lineChartView.marker = GraphPointMarkerView.fromNib()
        lineChartView.drawGridBackgroundEnabled = false //Disable drawing that grid background.
        //updateChart()
    }
    
    func updateChart(){
        //We will fetch our data points and turn them into a frontend representation (that isn't a ManagedObject). This will make things a bit cleaner.
        var dataPoints = [FrontendGraphDataPoint]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GraphDataPoint")
        //At this point, if we wanted to add extra conditions, we'd change request.predicate. For now, we don't.
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try Constants.moc.fetch(request) as! [NSManagedObject]
            //Now, we'll do things in here with result.
            for dataPoint in result {
                //For each data point, we will append it to the end of the dataPoints array.
                guard let title = dataPoint.value(forKey: "surveyTitle") as? String else { throw DataFetchError.titleError }
                guard let date = dataPoint.value(forKey: "date") as? Date else { throw DataFetchError.dateError }
                guard let phq = dataPoint.value(forKey: "phq") as? Int else { throw DataFetchError.phqError }
                guard let notes = dataPoint.value(forKey: "notes") as? String else { throw DataFetchError.notesError }
                //Admittedly, this is the kinder "don't crash if something that should never happens" way. It's a bit more code, but it's also a bit more graceful in action, should it ever matter.
                dataPoints.append(FrontendGraphDataPoint(title: title, date: date, phq: phq, notes: notes))
            }
            //This is admittedly a bit silly, but it's a decent example of what do-try-catch blocks can be like in Swift. I don't often do this sort of thing, but...
        } catch DataFetchError.titleError {
            self.presentDialogBox(withTitle: "Title Error", withMessage: "Fetching the title for some data entry failed. Please try again.")
        } catch DataFetchError.dateError {
            self.presentDialogBox(withTitle: "Date Error", withMessage: "Fetching the date for some data entry failed. Please try again.")
        } catch DataFetchError.phqError {
            self.presentDialogBox(withTitle: "PHQ Error", withMessage: "Fetching the PHQ score for some data entry failed. Please try again.")
        } catch DataFetchError.notesError {
            self.presentDialogBox(withTitle: "Notes Error", withMessage: "Fetching the notes for some data entry failed. Please try again.")
        } catch {
            self.presentDialogBox(withTitle: "Unknown Error", withMessage: "I hope you haven't been showering with your phone, because that could explain how you got this error; I certainly can't.")
        }
        //If our result is empty, we should return.
        if dataPoints.isEmpty { return }
        
        //Now that we're done with all that junk, let's actually use what we just fetched.
    
        //Let's first make sure our data is ordered as we want it to. Ordering our data points will also make it a bit easier to set our chart's axes. We can do this because we implemented the comparator for this custom type.
        dataPoints.sort()
        //I'm not thinking particularly hard right now, so it's possible there's a more efficient way to implement this.
        
        //Now that I think about it, the sorting might not be necessary. ToDo: Test to see if we can get rid of it.
        
        //Now, the date of the first one can be the start of the graph's time period and the date of the last one can be the end. We can also extend these somewhat...
        //We still need to convert these to a [ChartDataEntry]().
        
        var lineChartEntries = [CustomGraphDataPoint]()
        //If 0 is our first point's date, then...
        let firstDate = dataPoints.first!.date
        
        //Let's make a DateFormatter to help us make our date strings.
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        //If we care enough, we can eventually set .locale to change to the user's. That doesn't really matter right now, though.
        
        for point in dataPoints {
            //Get the amount of time between the first date and this date as a Double
            let elapsedTime = Double(point.date.timeIntervalSince(firstDate))
            //Generate the dateString from the date with our DateFormatter.
            let dateString = dateFormatter.string(from: point.date)
            
            //Create a new ChartDataEntry with this information and the appropriate PHQ score and notes
            let entry = CustomGraphDataPoint(x: elapsedTime, y: Double(point.phq), dateString: dateString, notes: point.notes)
            //Add the ChartDataEntry to the array
            lineChartEntries.append(entry)
        }
        
        //Now let's set the graphical information.
        let line = LineChartDataSet(values: lineChartEntries, label: "Score")
        //We might be able to customize the label.
        
        //So we don't have to print out the decimal places that our cast to Double would otherwise impose,
        //let's give line our custom number formatter.
        line.valueFormatter = GraphValueFormatter();
        
        //This is customizable to a high degree - line.valueFont can be changed, for example.
        
        //Later on, we may want to color-code the entries. We should be able to do that.
        //line.colors = []
        
        
        let data = LineChartData() //This finally being the object we insert into the chart...
        data.addDataSet(line)
        
        lineChartView.data = data //and we set the chart view's data to the object we just prepared.
        
        lineChartView.chartDescription?.text = "\(dataPoints.first!.title) results"
        
        //Charts forces us to work with floating-point units, but we don't need floating-point anything (yet).
        //This might be something subject to change in the future, but for now, I'll add stuff to make the
        //chart a little more integer-friendly.
        
        lineChartView.leftAxis.granularity = 1.0
        lineChartView.rightAxis.granularity = 1.0 //The left and right axes should now be granular to the nearest integer or so. (May still need testing)
        
        lineChartView.xAxis.drawLabelsEnabled = false //These numbers don't actually mean much to the end-user; they're just the time in seconds since the first point, and they might be confusing.
        
        //Now let's set the other miscellaneous graphical details here.
        //If we're up for it, we can these sorts of things be changed by user-specified settings.
        //I'm not going to implement that just yet.
        lineChartView.drawGridBackgroundEnabled = false //Disable drawing that grid background.
        lineChartView.noDataText = "There's no data here! You'll have to take a survey first."
        
        
    }
    
    
    
}
