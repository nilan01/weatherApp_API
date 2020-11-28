//
//  LocationsTableViewController.swift
//  weatherApp_API
//
//  Created by user182271 on 11/26/20.
//

import UIKit



class LocationsTableViewController: UITableViewController, UISearchBarDelegate, ServiceDelegate {
    var locations : [Location] = []
    
    var arrayOfLocas : [Loca] = []


    func serviceDelegateDidFinishWithDictinary(result: [String]) {
        arrayOfLocas.removeAll()
        locationSet = result;
        
        for var i in locationSet!{
            let index = i.firstIndex(of: ",")!
            let city = i[..<index]
            //print(city)
            
            //let index2 = i.lastIndex(of: ",")!
            var stringArr = i.components(separatedBy: ",")
            let country = stringArr.last
            print(country)
            var place = Loca(cty: String(city), ctry: String(country!))
            arrayOfLocas.append(place)
            DispatchQueue.main.async {
                       self.tableView.reloadData()
            }
            //CoreDataManager.shared.insertNewLocation(city: String(city), country: String(country))
        }

        
    }
    
    

    
    var locationSet : [String]?
    
    func serviceDelegateDidFinishWithData(location: Location) {
        
    }
    

    
    //SearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //print(searchText.count);
        if(searchText.count >= 3){
            myService.fetchFromYahoo(key: searchText) { (result) in
                //print(result)
                self.locationSet = result
                       DispatchQueue.main.async {
                                  self.tableView.reloadData()
                              }
            }

        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    lazy var myService : Service = {
        let service = Service()
        service.delegate = self
        return service
    }()
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayOfLocas.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = "\(arrayOfLocas[indexPath.row].cty)"
        cell.detailTextLabel?.text = "\(arrayOfLocas[indexPath.row].ctry)"
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedFriend = arrayOfEmployees[indexPath.row]
        //i = indexPath.row + 1
        let alert = UIAlertController.init(title: "Save this city?", message:"", preferredStyle: .alert)
        

        
        let action = UIAlertAction.init(title: "Ok", style: .default){(action) in
            //if let correctTask = textField.text{
            let selectedLocation = self.arrayOfLocas[indexPath.row]
            //print(selectedLocation.ctry + "YEEEEE")
            CoreDataManager.shared.insertNewLocation(city: selectedLocation.cty, country: selectedLocation.ctry)
            //}
            //print("WAGWEEZZYYYY")d
            //popViewController(animated:)
           
            self.navigationController?.popViewController(animated: true)
        }
        /*let cancelAction = UIAlertAction.init(title: "Cancel", style: .default){(action) in
            self.dismiss(animated:true, completion: nil)
        }*/
        alert.addAction(action)
        //alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
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
