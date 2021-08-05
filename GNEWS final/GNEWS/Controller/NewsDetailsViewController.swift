//
//  NewsDetailsViewController.swift
//  GNEWS
//
//  Created by ChethanBhandarkar on 29/07/21.
//

import Foundation
import UIKit

class NewsDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var detailsNewsImage: UIImageView!
    
    @IBOutlet weak var detailsNewsTitle: UILabel!
    
    
    @IBOutlet weak var detailsNewsAuthor: UILabel!
    
    @IBOutlet weak var detailsNewsContent: UILabel!
    
    var newsArticle:NewsData.Article?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsNewsTitle.text=newsArticle?.title
        detailsNewsAuthor.text=newsArticle?.author
        detailsNewsImage.loadUrlImage(urlstring: (newsArticle?.urlToImage!)!)
        detailsNewsContent.text=newsArticle?.content
//
        
   
        //doubt
//           newsObjectClosure =
//            { NewsArticle in
//            print(NewsArticle.title)
//            print("here")
//            print("again")
//            self.detailsNewsTitle.text=NewsArticle.title
//
//
//        }
      //  newsObjectClosure(NewsData.Article(title:"hyff"))
    
    
    
}
}
