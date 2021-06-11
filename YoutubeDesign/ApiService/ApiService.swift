//
//  ApiService.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 10.06.2021.
//

import UIKit

class ApiService: NSObject {

//    static let sharedInstance = ApiService()
//
//    func fetchVideos(completion: ([Video]) -> ()){
//        let urlJson = "https://s3-us-west-2.amazonaws.com/youtubeassets%2Fhome.json"
//        guard let url = URL(string: urlJson) else {return}
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if error != nil{
//                print(error as Any)
//                return
//            }
//
//            do{
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//                var videos = [Video]()
//
//                for dictionary in json as! [[String: AnyObject]]{
//                    let video = Video()
//                    video.title = dictionary["title"] as? String
//                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//
//                    let channelDictionaries = dictionary["channel"] as! [String: AnyObject]
//                    let channel = Channel()
//                    channel.name = channelDictionaries["name"] as? String
//                    channel.profileImageName = channelDictionaries["profile_image_name"] as? String
//
//                    video.channel = channel
//
//                    videos.append(video)
//                }
//
//                DispatchQueue.main.async {
//                    completion(videos)
//                }
//
//            }catch let jsonError{
//                print(jsonError)
//            }
//
//        }.resume()
    
}
