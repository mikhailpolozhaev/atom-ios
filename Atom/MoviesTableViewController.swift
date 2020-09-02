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

    var items:[MovieResult] = []
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
        if let imagePath = item.backdropPath {
            AF.download("https://image.tmdb.org/t/p/original" + imagePath).responseData { response in
                if let data = response.value {
                    cell.movieImage?.image = UIImage(data: data)
                }
            }
        }else{
              cell.movieImage?.image = nil
        }
        
        if indexPath.row == items.count - 1 { // last cell
            if totalPages > pages { // more items to fetch
               
                fechData()
            }
        }
        return cell
    }
    
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
        let parameter = ["api_key":Api.API_KEY,"page": pages ] as [String : Any]
        let request = AF.request(Api.Path.MOVIES_POPULAR, parameters: parameter)
        request.responseDecodable(of: MoviesResponse.self ){ response in
            debugPrint(response)
            guard let movies = response.value else { return }
            self.items.append(contentsOf: movies.results)
            self.totalPages = movies.totalPages
            self.pages += 1
            self.tableView.reloadData()
        }
    }
    
}
