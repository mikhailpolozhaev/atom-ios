//
//  MoviesTableViewController.swift
//  Atom
//
//  Created by Mikhail Polozhaev on 31/08/2020.
//  Copyright © 2020 Mikhail Polozhaev. All rights reserved.
//

import UIKit
import Alamofire

class MoviesTableViewController: UITableViewController {
    
    var items: [MovieResult] = []
    var totalPages = 0
    var pages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fechData()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1	
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell

        // Configure the cell...
        let item = items[indexPath.row]
        cell.title?.text = item.title
        cell.movieDetail?.text = item.overview
        
        AF.download("https://image.tmdb.org/t/p/original" + item.backdropPath).responseData { response in
            if let data = response.value {
                cell.movieImage?.image = UIImage(data: data)
            }
        }

        
        if indexPath.row == items.count - 1 { // last cell
            if totalPages > pages { // more items to fetch
                fechData() 
            }
        }
        return cell
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idMovie = items[indexPath.row].id
        self.performSegue(withIdentifier: "detailSegue", sender: idMovie)
    }
    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "detailSegue" {
            let idMovie = sender as! Int
            
            let detailViewController:DetailViewController = segue.destination as! DetailViewController
            detailViewController.movieId = idMovie
        }
        
    }
    

    func fechData(){
        let parameter = ["api_key":"51c4fa35a77d9ec54452516884169794","page": pages ] as [String : Any]
               
        let request = AF.request("https://api.themoviedb.org/3/movie/popular",parameters: parameter)
        request.validate()
        request.responseDecodable(of: MoviesResponse.self ){ response in
            
            guard let movies = response.value else { return }
            self.items.append(contentsOf: movies.results)
            self.totalPages = movies.totalPages
            self.pages += 1
            self.tableView.reloadData()
        }
    }
    
}
