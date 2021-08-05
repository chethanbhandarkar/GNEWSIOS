//
//  NewsTableViewCell.swift
//  GNews
//
//  Created by ChethanBhandarkar on 27/07/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    func setNews(newsObject : NewsData.Article){
        
        self.newsTitle.text="Loading.."
        newsImage.isHidden=true
        guard newsObject.urlToImage != nil else {
          return
        }
        //DOUBT 2 : clousre   returns after all images set
   
        //loadUrlImage is a extension stored in Utilities folder
        
        newsImage.loadUrlImage(urlstring: newsObject.urlToImage!)
        self.newsTitle.text=newsObject.title
        loadingIndicator.isHidden=true
        newsImage.isHidden=false
    }
}


