struct MovieResult:Decodable{
    
    let id:Int
    let overview:String
    let originalLanguage:String
    let originalTitle:String
    let popularity:Double
    let posterPath:String
    let backdropPath:String?
    let releaseDate:String
    let title:String
    let voteAverage:Double
    let voteCount:Int
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case overview
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
}

