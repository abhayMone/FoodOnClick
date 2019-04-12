//
//  ViewController.swift
//  FoodOnClick
//
//  Created by abhay mone on 4/17/18.
//  Copyright © 2018 abhay mone. All rights reserved.
//

import UIKit
import CoreML
import CoreData

class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    var foodName : String!
    @IBOutlet weak var percentage: UILabel!
    
    //action for restaurant button
    @IBAction func restaurant_button(_ sender: UIButton)
    {
    
        if self.foodName == nil{
            
            let alert = UIAlertController(title: "Food not found", message: "Pick a food item to continue", preferredStyle: .alert)
            
            let action_ok = UIAlertAction(title: "ok", style: .default, handler: { (action) in
                
            })
            //alert if food item is not selected
            alert.addAction(action_ok)
            present(alert, animated: true, completion: nil)
        }
        else{
            //segue for restaurant view controller
            performSegue(withIdentifier: "restaurantSegue", sender: self)
        }
        
      
    }
    
    @IBAction func recentSearches(_ sender: UIButton) {
        
           //segue for recent searches view controller
        performSegue(withIdentifier: "tableSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

        switch segue.identifier {
        case "restaurantSegue"?:
            
            let search = Searches(context: PersistenceService.context)
    
            search.foodItem = self.foodName
            PersistenceService.saveContext()
            let restaurantController = segue.destination as! RestaurantViewController
            restaurantController.food_item = self.foodName
            // prepare something
            
            
            
            break
            
        case "tableSegue"?:
            segue.destination as! HistoryViewController

            
            break
        default: break
        }
        
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //Pick a food option : take image or choose image , Cancel
    @IBAction func buttonPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let imagePickerView = UIImagePickerController()
        imagePickerView.delegate = self

        alert.addAction(UIAlertAction(title: "Choose Image", style: .default) { _ in
            imagePickerView.sourceType = .photoLibrary
            self.present(imagePickerView, animated: true, completion: nil)
        })

        alert.addAction(UIAlertAction(title: "Take Image", style: .default) { _ in
            imagePickerView.sourceType = .camera
            self.present(imagePickerView, animated: true, completion: nil)
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    //pick a food: Cancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       
        dismiss(animated: true, completion: nil)
    }
    
    //pick a food : take image or choose image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        dismiss(animated: true, completion: nil)
       
        guard let image = info["UIImagePickerControllerOriginalImage"] as? UIImage else {
            return
        }

        processImage(image)
    }
    
    // CORE ML food prediction process
    func processImage(_ image: UIImage) {
        let model = Food101()
        let size = CGSize(width: 299, height: 299)

        guard let buffer = image.resize(to: size)?.pixelBuffer() else {
            fatalError("Scaling or converting to pixel buffer failed!")
        }

        guard let result = try? model.prediction(image: buffer) else {
            fatalError("Prediction failed!")
        }

        let confidence = result.foodConfidence["\(result.classLabel)"]! * 100.0
       
        //let converted = String(format: "%.2f", confidence)

        if confidence >= 60 {
            
            imageView.image = image
            percentage.text = "\((result.classLabel).replacingOccurrences(of: "_", with: " "))"
            foodName = (result.classLabel).replacingOccurrences(of: "_", with: " ")
        }
        else {
            
            let alert = UIAlertController(title: "Unable to recognize", message: "Pick another food item to continue", preferredStyle: .alert)
            
            let action_ok = UIAlertAction(title: "ok", style: .default, handler: { (action) in
                
            })
            
            alert.addAction(action_ok)
            present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
