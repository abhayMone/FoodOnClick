//
//  HistoryViewController.swift
//  FoodOnClick
//
//  Created by abhay mone on 4/22/18.
//  Copyright © 2018 abhay mone. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var searches = [Searches]()
    var foodName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //fetching the data from the persistent data model
        let fetchRequest : NSFetchRequest<Searches> = Searches.fetchRequest()

        fetchRequest.returnsObjectsAsFaults = false

        do {
             let recentsearches = try PersistenceService.context.fetch(fetchRequest)
                self.searches = recentsearches

            
        } catch {
                print(error)
        }
    
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        //segue for RestaurantViewController
        let restaurantController = segue.destination as! RestaurantViewController
        restaurantController.food_item = self.foodName
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView : UITableView, cellForRowAt indexpath : IndexPath) -> UITableViewCell {
        
        //populating the table view
        let cell = UITableViewCell()
        cell.textLabel?.text = searches[indexpath.row].foodItem
        return cell
    }
    
    func tableView(_ tableView : UITableView, didSelectRowAt indexpath : IndexPath) {
        
        
        let currentCell = tableView.cellForRow(at: indexpath) as! UITableViewCell
        
        foodName = currentCell.textLabel!.text
     
        
        //navigating to Restaurant screen
        performSegue(withIdentifier: "recenttores", sender: self)
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
    
        return searches.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


