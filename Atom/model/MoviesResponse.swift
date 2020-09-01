struct MoviesResponse:Decodable {
    
    let page: Int
    let totalPages: Int
    let totalResults:Int
    let results: [MovieResult]
    
    enum CodingKeys: String, CodingKey {
      case page
      case totalPages = "total_pages"
      case totalResults = "total_results"
      case results = "results"
    }
}
