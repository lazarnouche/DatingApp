//
//  PeopleTableViewController.swift
//  DatingApp
//
//  Created by Laurent Azarnouche on 12/17/20.
//

import UIKit

class PeopleTableViewController: UITableViewController, UISearchResultsUpdating {

    

    var users: [User] = []
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var searchResults: [User] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBarController()
        setupNavigationBar()
        observeUsers()
        setupTableView()


    }
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty {
            view.endEditing(true)
        } else {
            let textLowercased = searchController.searchBar.text!.lowercased()
            filterContent(for: textLowercased)
        }
        tableView.reloadData()
        
    }
    
    func filterContent(for searchText: String) {
        searchResults = self.users.filter {
            return $0.username.lowercased().range(of: searchText) != nil
        }
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        
    }
 
    func setupSearchBarController(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search users"
        searchController.searchBar.barTintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func setupNavigationBar(){
        navigationItem.title = "People"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    func observeUsers(){
        
        Api.User.observeUsers { (user) in
            self.users.append(user)
            self.tableView.reloadData()
        }
 
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchController.isActive ? searchResults.count : self.users.count

        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_USERS, for: indexPath) as! UserTableViewCell
        
        let user = searchController.isActive ? searchResults[indexPath.row] : users[indexPath.row]
            
        cell.loadData(user)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserTableViewCell{
            let storyboard =  UIStoryboard(name: "Welcome", bundle: nil)

            let ChatVC = storyboard.instantiateViewController(withIdentifier: IDENTIFIER_CHAT)
            as! ChatViewController
            
            ChatVC.partnerId = cell.user.uid    
            ChatVC.imagePartner = cell.avatar.image
            ChatVC.partenerUsername = cell.usernameLbl.text
            self.navigationController?.pushViewController(ChatVC, animated: true)
 
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
