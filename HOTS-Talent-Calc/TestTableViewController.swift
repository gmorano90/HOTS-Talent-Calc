//
//  TestTableViewController.swift
//  HOTS-Talent-Calc
//
//  Created by Greg Morano on 7/31/17.
//  Copyright © 2017 Greg Morano. All rights reserved.
//

import UIKit

class TestTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    var heroes:[BasicHero] = heroesData
    let searchController = UISearchController(searchResultsController: nil)
    var filteredHeroes = [BasicHero]()
    var choices:[String] =  ["Choice1", "Choice2", "Choice3"]
    var isAnimating: Bool = false
    var dropDownViewIsDisplayed: Bool = false
    var dropDown: UIPickerView!
    //@IBOutlet weak var dropDown: UIPickerView!
    //@IBOutlet weak var dropDownView: UIView!
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return choices.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let height: CGFloat = 110
        let width: CGFloat = 375
        self.dropDown = UIPickerView(frame: CGRect(x: 0, y: -height, width: width, height: height))
        
        self.dropDown.delegate = self
        self.dropDown.dataSource = self
  
        //let height: CGFloat = self.dropDown.frame.size.height
        //let width: CGFloat = self.dropDown.frame.size.width
        
        //var frame: CGRect = CGRect(x: 0, y: -height, width: width, height: height)//CGRect(0, -height, width, height)
        //frame.origin.y = -height
        //self.dropDown.frame = frame
        self.dropDownViewIsDisplayed = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    @IBAction func barButtonItemPressed(sender: UIBarButtonItem?) {
        if (self.dropDownViewIsDisplayed) {
            self.hideDropDownView()
        } else {
            self.showDropDownView()
        }
    }
    
    func hideDropDownView() {
        var frame: CGRect = self.dropDown.frame
        frame.origin.y = -frame.size.height
        self.animateDropDownToFrame(frame: frame) {
            self.dropDownViewIsDisplayed = false
        }
    }
    
    func showDropDownView() {
        var frame: CGRect = self.dropDown.frame
        frame.origin.y = 200
        self.animateDropDownToFrame(frame: frame) {
            self.dropDownViewIsDisplayed = true
        }
    }
    
    func animateDropDownToFrame(frame: CGRect, completion:@escaping () -> Void) {
        if (!self.isAnimating) {
            self.isAnimating = true
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: { () -> Void in
                self.dropDown.frame = frame
            }, completion: {(completed: Bool) -> Void in
                self.isAnimating = false
                if (completed) {
                    completion()
                }
            })
        }
    }

}
