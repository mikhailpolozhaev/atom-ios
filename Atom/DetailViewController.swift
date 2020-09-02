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
        let parameter = ["api_key":Api.API_KEY] as [String : Any]
        let request = AF.request("https://api.themoviedb.org/3/movie/\(movieId!)",parameters: parameter)
         
        request.responseDecodable(of: Movie.self){ response in
            guard let movies = response.value else { return }
            self.setUp(data: movies)
        }
    }
    
    func setUp(data:Movie){
        
        let genres = data.genres?.compactMap({$0.name}).joined(separator: " | ")
        let companies = data.productionCompanies?.compactMap({$0.name}).joined(separator:", ")
        let languages = data.spokenLanguages?.compactMap({$0.name}).joined(separator:", ")
        
        titleLabel.text = data.originalTitle
        typeLabel.text = genres
        overviewLabel.text = data.overview
        productionCompLabel.text = companies
        popularityLabel.text = "\(data.popularity) votes"
        statusLabel.text = data.status
        budgetLabel.text = "\(data.budget)"
        spokeLabel.text = languages
        
        fetchImage(image: data.backdropPath)
        
    }
    
    func fetchImage(image:String){
        AF.download(Api.Path.IMAGE + image).responseData { response in
            if let data = response.value {
                self.movieImageView.image = UIImage(data: data)
            }
        }
    }

}
