//
//  DetailViewController.swift
//  Atom
//
//  Created by Mikhail Polozhaev on 31/08/2020.
//  Copyright © 2020 Mikhail Polozhaev. All rights reserved.
//

import UIKit
import Alamofire
class DetailViewController: UIViewController {
 
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    
    @IBOutlet var productionCompLabel: UILabel!
    @IBOutlet var popularityLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    @IBOutlet var budgetLabel: UILabel!
    
    @IBOutlet var spokeLabel: UILabel!
    var movieId:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        let parameter = ["api_key":"51c4fa35a77d9ec54452516884169794"] as [String : Any]
                   
            let request = AF.request("https://api.themoviedb.org/3/movie/\(movieId!)",parameters: parameter)
         
            request.responseDecodable(of: Movie.self){ response in
                guard let movies = response.value else { return }
                self.setUpData(data: movies)
            }
        
    }
    
    func setUpData(data:Movie){
        
        debugPrint(data.overview)
        titleLabel.text = data.originalTitle
        typeLabel.text = "News | Fantasy | Adventure" //TODO: change this
        overviewLabel.text = data.overview
        productionCompLabel.text = "walt Disney Pictures.Demo"
        popularityLabel.text = "\(data.popularity) votes"
        statusLabel.text = data.status
        budgetLabel.text = "\(data.budget)"
        spokeLabel.text = data.overview // TODO: change this
        
        fetchImage(image: data.backdropPath)
        
    }
    
    func fetchImage(image:String){
        AF.download("https://image.tmdb.org/t/p/original" + image).responseData { response in
                if let data = response.value {
                    self.movieImageView.image = UIImage(data: data)
                }
            }
    }

}
