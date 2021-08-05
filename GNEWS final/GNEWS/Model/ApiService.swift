//
//  ApiService.swift
//  GNews
//
//  Created by ChethanBhandarkar on 27/07/21.
//

import Foundation

class ApiService{
    
    static let shared=ApiService()
    private init(){ }
    
    private let baseUrlString:String="https://newsapi.org/"
    
    //Top Headlines / Search News  based on Query nil or not
    
    func getNews(query:String?=nil,completionHandler :@escaping (NewsData)->Void){
        let urlString:String
        
        
        //set url based or query nil or not
        urlString = query == nil ? baseUrlString + "v2/top-headlines?sources=google-news&apikey=04dd1e279fcd4dd0a9b27d4e55760f9f": baseUrlString + "v2/everything?q=\(query!)&apikey=04dd1e279fcd4dd0a9b27d4e55760f9f&sortBy=publishedAt"
        
        let url=URL(string:urlString)
        guard url != nil else {
            return
        }
        
        //URL Session
        let session = URLSession.shared
        let dataTask=session.dataTask(with: url!){ (data,response,error) in
            if error == nil && data != nil
            {
                let decoder=JSONDecoder()
                do{
                    let news=try decoder.decode(NewsData.self,from:data!)
                    
                    DispatchQueue.main.async {
                       completionHandler(news)
                    }
                  
                }
                //DOUBT Kind of errors to catch
                catch{
                    print("error")
                }
            }
            else{
                print("error")
            }
        }
        dataTask.resume()
    }
}



