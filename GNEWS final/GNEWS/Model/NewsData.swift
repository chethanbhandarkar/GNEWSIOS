//
//  NewsData.swift
//  GNews
//
//  Created by ChethanBhandarkar on 27/07/21.
//

import Foundation

struct NewsData: Codable {
 
    var status: String = ""
  
    var totalResults: Int = 0
 
    var articles: [Article]

    struct Article: Codable {
       
        var source: Source?=nil
  
        var author: String? = nil

        var title: String? = nil
  
        var description: String? = nil
     
        var url: String? =  nil
     
        var urlToImage: String? = nil
 
        var publishedAt: String? = nil
     
        var content: String? = nil
   
        struct Source: Codable{
            
            var id: String? = nil
        
            var name: String? = nil
     
    }

}

}
