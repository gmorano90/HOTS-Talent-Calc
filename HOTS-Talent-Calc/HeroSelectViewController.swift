//
//  HeroSelectViewController.swift
//  HOTS-Talent-Calc
//
//  Created by Greg Morano on 7/28/17.
//  Copyright © 2017 Greg Morano. All rights reserved.
//

import UIKit


class HeroSelectViewController: UITableViewController {

    var heroes:[BasicHero] = heroesData
    let searchController = UISearchController(searchResultsController: nil)
    var filteredHeroes = [BasicHero]()
    var filtered: Bool = false
    var filterString = "All"
    
    @IBOutlet weak var selectedCellLabel: UILabel!
    @IBOutlet weak var navOptionView: UIView!
    var menuView: BTNavigationDropdownMenu!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let backView = UIView(frame: self.tableView.bounds)
        backView.backgroundColor = UIColor(red: 31, green: 16, blue: 51, alpha: 0)
        self.tableView.backgroundView = backView
        
        
        searchController.searchResultsUpdater = self as UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.backgroundImage = #imageLiteral(resourceName: "background")
        searchController.searchBar.placeholder = "Search Hero"
        self.extendedLayoutIncludesOpaqueBars = true
        self.searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = false
        tableView.tableHeaderView = searchController.searchBar
        

        let items = ["All", "Assassin", "Warrior", "Support", "Specialist", "Multiclass"]
        self.navigationController?.navigationBar.isTranslucent = false
        //self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.0/255.0, green:180/255.0, blue:220/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // "Old" version
        // menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Dropdown Menu", items: items)
        
        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: "Filter", items: items)
        
        
        menuView.cellHeight = 50
        menuView.cellBackgroundColor = self.navigationController?.navigationBar.barTintColor
        //menuView.cellSelectionColor = UIColor(red: 0.0/255.0, green:160.0/255.0, blue:195.0/255.0, alpha: 1.0)
        menuView.shouldKeepSelectedCellColor = true
        menuView.cellTextLabelColor = UIColor.white
        menuView.cellTextLabelFont = UIFont(name: "Avenir-Heavy", size: 17)
        menuView.cellTextLabelAlignment = .left // .Center // .Right // .Left
        menuView.arrowPadding = 15
        menuView.animationDuration = 0.5
        menuView.maskBackgroundColor = UIColor.black
        menuView.maskBackgroundOpacity = 0.3
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> Void in
            //print("Did select item at index: \(indexPath)")
            //do crap here with the selected value
            if(items[indexPath].lowercased() == "all" ){
                self.filtered = false
            }
            else{
                self.filtered = true
            }
            self.filterString = items[indexPath]
            self.filterContentForFilterChoice(filterChoice: items[indexPath])
        }
        self.navigationItem.rightBarButtonItem?.customView = menuView

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (searchController.isActive && searchController.searchBar.text != "") || self.filtered == true {
            return filteredHeroes.count
        }
        
        return heroesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath)as! HeroCell
        
        if (searchController.isActive && searchController.searchBar.text != "") || self.filtered == true {
            let hero = filteredHeroes[indexPath.row] as BasicHero
            cell.hero = hero
        }
        else{
            let hero = heroes[indexPath.row] as BasicHero
            cell.hero = hero
        }
        
        return cell
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        if(self.filtered == true && searchText == ""){
            self.filterContentForFilterChoice(filterChoice: self.filterString)
        }
        else if(self.filtered == true ){
            self.reloadFilterData(filterChoice: self.filterString)
            filteredHeroes = filteredHeroes.filter { hero in
                return (hero.name?.lowercased().contains(searchText.lowercased()))!
            }
        }
        else{
            filteredHeroes = heroesData.filter { hero in
                return (hero.name?.lowercased().contains(searchText.lowercased()))!
            }
        }
        tableView.reloadData()
    }
    
    func filterContentForFilterChoice(filterChoice: String){
        if(searchController.isActive && searchController.searchBar.text != ""){
            self.reloadSearchData(searchText: searchController.searchBar.text!)
            if(filterChoice.lowercased() != "all"){
                filteredHeroes = filteredHeroes.filter { hero in
                    return (hero.type?.lowercased().contains(filterChoice.lowercased()))!
                }
            }
        }
        else{
            filteredHeroes = heroesData.filter { hero in
                return (hero.type?.lowercased().contains(filterChoice.lowercased()))!
            }
        }
        
        tableView.reloadData()
    }
    
    func reloadFilterData(filterChoice: String){
        filteredHeroes = heroesData.filter { hero in
            return (hero.type?.lowercased().contains(filterChoice.lowercased()))!
        }
    }
    
    func reloadSearchData(searchText: String){
        filteredHeroes = heroesData.filter { hero in
            return (hero.name?.lowercased().contains(searchText.lowercased()))!
        }
    }
    
    @IBAction func backToHeroSelectViewController(segue:UIStoryboardSegue) {
    }

}

extension HeroSelectViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchText: searchController.searchBar.text!)
        
    }
}

