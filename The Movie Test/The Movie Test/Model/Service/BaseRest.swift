//
//  BaseRest.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 30/08/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//


import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class BaseRest {
    
    let baseURL = "https://api.themoviedb.org/3/"
    let api_key = "api_key=2bae12ea6f75b14280cce8dc6ea5f242"
    let endOfURL = "&language=pt-BR"
    

    var TopMovies:[Movie] = []
    var PopMovies:[Movie] = []
    var NowMovies:[Movie] = []
    var TheMovie:[Movie] = []
    var Videos:[Video] = []
    var Filme: ResMovie = ResMovie()
    
  
    
    func getPopular(){
        let url = baseURL+EnumURL.Populares.path+api_key+endOfURL
        Alamofire.request(url).responseArray(keyPath: "results") { (response: DataResponse<[Movie]>) in
            switch response.result {
            case .success( _):
            if let movies = response.result.value{
                for Movie in movies{
                    self.PopMovies.append(Movie)
                }
            }
            case .failure(let value):
                print(value)
            }
        }
    }
    
    func getNowPlaying(){
        let url = baseURL+EnumURL.EmCartaz.path+api_key+endOfURL
        Alamofire.request(url).responseArray(keyPath: "results") { (response: DataResponse<[Movie]>) in
            switch response.result {
            case .success(_):
            if let movies = response.result.value{
                for Movie in movies{
                    self.NowMovies.append(Movie)
                }
            }
            case .failure(let value):
                print(value)
            }
        }
    }
    
    func getSearch(filme:String){
        let url = baseURL+EnumURL.Pesquisar.path+api_key+endOfURL
        Alamofire.request(url).responseObject(completionHandler: { (response: DataResponse<Movie>) in
            if let filme = response.result.value{
                return self.TheMovie.append(filme)
            }
        });
    }

    func getVideo(filme:Int){
        let url = baseURL+EnumURL.Video(filme).path+api_key+endOfURL
        Alamofire.request(url).responseArray(keyPath: "results") { (response: DataResponse<[Video]>) in
            if let movies = response.result.value{
                for movie in movies{
                    self.Videos.append(movie)
                }
            }
        }
    }
    
    func getMovie(filme:Int){
        let url = baseURL+EnumURL.Filme(filme).path+api_key+endOfURL
        Alamofire.request(url).responseObject(completionHandler: {
            (response: DataResponse<ResMovie>) in
            self.Filme = response.result.value ?? ResMovie()
        })
    }
    
}
