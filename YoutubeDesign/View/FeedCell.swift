//
//  FeedCell.swift
//  YoutubeDesign
//
//  Created by Dastan Zhapay on 11.06.2021.
//

import UIKit

class FeedCell: BaseCell {

    private let cellId = "cellId"
    
    var videos: [Video]?
    
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func fetchVideos(){
        let urlJson = "https://s3-us-west-2.amazonaws.com/youtubeassets%2Fhome.json"
        guard let url = URL(string: urlJson) else {return}

        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if error != nil{
                print(error as Any)
                return
            }

            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)

                self.videos = [Video]()

                for dictionary in json as! [[String: AnyObject]]{
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber

                    let channelDictionaries = dictionary["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDictionaries["name"] as? String
                    channel.profileImageName = channelDictionaries["profile_image_name"] as? String

                    video.channel = channel

                    self.videos?.append(video)
                }

                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }

            }catch let jsonError{
                print(jsonError)
            }

        }.resume()
    }
    
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(collectionView)
        
        fetchVideos()
        setupConstraints()
        configureCollectionView()
    }
    
    private func configureCollectionView(){
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    private func setupConstraints(){
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(self)
        }
    }
}

//MARK: CV DataSource, Delegate
extension FeedCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
        let selectedIndex = videos?[indexPath.item]
        cell.video = selectedIndex
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 16 - 16) * 9/16
        return CGSize(width: frame.width, height: height + 16 + 68)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
