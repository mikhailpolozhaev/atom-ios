//
//  Movie.swift
//  Atom
//
//  Created by Mikhail Polozhaev on 31/08/2020.
//  Copyright © 2020 Mikhail Polozhaev. All rights reserved.
//
struct Movie:Decodable {

    let id:Int
    let overview:String
    let originalLanguage:String
    let originalTitle:String
    let popularity:Double
    let posterPath:String
    let backdropPath:String
    let releaseDate:String
    let title:String
    let voteAverage:Double
    let voteCount:Int
    let budget:Int
    let status:String
    let tagline:String
    let productionCompanies:[Companie]?
    let spokenLanguages:[Languaje]?
    let genres:[Genre]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case productionCompanies = "production_companies"
        case spokenLanguages = "spoken_languages"
        case popularity
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case budget
        case status
        case tagline
        case genres
    }
}
