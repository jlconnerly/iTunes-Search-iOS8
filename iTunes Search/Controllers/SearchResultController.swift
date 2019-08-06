//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Jake Connerly on 8/6/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

class SearchresultController {
    
    //
    //MARK: - Enums
    //
    
    enum HTTPMethod: String {
        case get    = "GET"
        case put    = "PUT"
        case post   = "POST"
        case delete = "DELETE"
    }
    
    //
    //MARK:- Properties
    //
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    var searchResults: [SearchResult] = []
    
    
    //
    //MARK: - Methods
    //
    
    func performSearch(with searchTerm: String, resultType: ResultType, completion: @escaping () -> Void) {
        
        var components         = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQueryItem    = URLQueryItem(name: "term", value: searchTerm)
        let searchTypeQueryItem = URLQueryItem(name: "entity", value: resultType.rawValue)
        components?.queryItems = [searchQueryItem, searchTypeQueryItem]
        
        guard let requestURL = components?.url else {
            NSLog("RequestURL is nil")
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from task: \(error)")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let searchResults = try jsonDecoder.decode(SearchResults.self, from: data)
                self.searchResults = searchResults.results
                
            } catch {
                NSLog("Unable to decode data into object of type [SearchResult]: \(error)")
            
            }
            completion()
        }.resume()
    }
}
