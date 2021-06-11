//
//  Extension+UIImageView.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 06.06.2021.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView{
    
    var imageUrlString: String?
    
    func loadImagesUsingUrl(urlString: String){
        guard let imgUrl = URL(string: urlString) else {return}
        
        imageUrlString = urlString
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: imgUrl) { (data, response, error) in
            
            if error != nil{
                print(error as Any)
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString{
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                
            }
            
        }.resume()
    }
    
}
