//
//  Extension.swift
//  GNEWS
//
//  Created by ChethanBhandarkar on 29/07/21.
//

import Foundation
import UIKit

var imageCache=NSCache<AnyObject,AnyObject>()
extension UIImageView{
    
    func loadUrlImage(urlstring:String)
    {
        if let image=imageCache.object(forKey: urlstring as NSString) as? UIImage
        {
            self.image=image
            return
        }
        
        guard let url=URL(string:urlstring) else{
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler:{
           (data,response,error)  in
            DispatchQueue.main.async {
                if let data=data{
                    if let image=UIImage(data:data)
                    {   imageCache.setObject(image, forKey:urlstring as NSString)
                        self.image=image
                    }
                }
            }
        }).resume()
    }
}


//METHOD 2 which one to use
//extension UIImageView{
//    func load(urlstring:String)
//    {
//
//        if let image=imageCache.object(forKey: urlstring as NSString) as? UIImage
//        {
//            self.image=image
//        }
//        print("called")
//        let url=URL(string:urlstring)!
//        DispatchQueue.global().async {
//            [weak self] in
//
//            if let data=try?Data(contentsOf: url)
//            {
//                if let image=UIImage(data:data)
//                {
//                    DispatchQueue.main.async {
//                        imageCache.setObject(image, forKey:urlstring as NSString)
//                        self!.image=image
//                    }
//                }
//            }
//        }
//    }
//
//
//}

