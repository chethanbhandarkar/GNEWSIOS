//
//  ViewController.swift
//  GNews
//
//  Created by ChethanBhandarkar on 27/07/21.
//

import UIKit


class NewsViewController: UIViewController {
    
   
    @IBOutlet weak var newsTableView: UITableView!
    var newsArticles:[NewsData.Article]=[]
    weak var api=ApiService.shared
    let searchConroller=UISearchController(searchResultsController: nil)
    
    var completionHandler:(NewsData)->Void={_ in }
    var newsObjectClosure:((NewsData.Article)->Void)?
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DELEGATION
        newsTableView.delegate=self
        newsTableView.dataSource=self
        searchConroller.searchBar.delegate=self
        
        navigationItem.searchController=searchConroller
        navigationItem.hidesSearchBarWhenScrolling=false
        searchConroller.obscuresBackgroundDuringPresentation=false
        
        newsTableView.estimatedRowHeight = 700
        newsTableView.rowHeight = UITableView.automaticDimension
      
        //code to executein api class after the value is returned from the call - is a escaping function
        //DOUBT1  - self
        completionHandler =
        {
            [weak self] NewsData in
            self?.newsArticles = []
            self?.newsArticles = NewsData.articles
            DispatchQueue.main.async {
            self?.newsTableView.reloadData()
            }
        }
        //default api call
        DispatchQueue.global().async {
            self.api?.getNews(query: nil, completionHandler: self.completionHandler)
        }
     
    }
    
  
}

//SEARCHBAR

extension NewsViewController: UISearchBarDelegate{
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let textToSearch = searchBar.text
        {     //api call with search
            api?.getNews(query:textToSearch,completionHandler: completionHandler)
        }
      searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        //call default api when close button pressed
        api?.getNews(completionHandler: completionHandler)
    }
}

//UITableView   -    NewsViewController Conforming to Delegates

extension NewsViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(newsArticles.count)
        return self.newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        let news = self.newsArticles[indexPath.row]
        let cell=tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsTableViewCell
        cell.setNews(newsObject: news)
        return cell
    }
    
    //DOUBT how to have a fixes ratio cell yet remain same  for all phones
    //commneted below line because used auto newsTableView.estimatedRowHeight = 700
   // newsTableView.rowHeight = UITableView.automaticDimension
//   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 350
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsSelected:NewsData.Article = self.newsArticles[indexPath.row] as NewsData.Article
   
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        weak var newsDetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailsScreen")  as? NewsDetailsViewController
           newsDetailViewController?.newsArticle=newsSelected
           navigationController?.pushViewController(newsDetailViewController!, animated: false)
       
         
        //above one is direct passing
      //  Tried delegation and closure to pass, but did not work need to know why and how to pass
 // let newsArticle=self.newsObjectClosure?(newsSelected)
       // newsObjectClosure!(NewsData.Article(title:"working"))

        
        
    }
    
}
