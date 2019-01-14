//
//  NewsTableViewCell.swift
//  bbcNews
//
//  Created by JJ Montes on 14/01/2019.
//  Copyright © 2019 jjmontes. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var publicationDate: UILabel!
    
    var cellModel: Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(newsItem: Item) {
        self.clearCell()
        
        self.cellModel = newsItem
        
        self.title.text = cellModel?.title
        self.newsDescription.text = cellModel?.description
        self.publicationDate.text = cellModel?.pubDate?.format(format: "yyyy/MM/dd HH:mm")
        
        self.getNewsImage(urlString: cellModel?.thumbnail?.url
        )
    }
    
    func clearCell() {
        self.title.text = ""
        self.newsDescription.text = ""
        self.publicationDate.text = ""
        self.newsImage.image = nil

    }
    
    func getNewsImage(urlString: String?){
        
        guard let urlString = urlString else { return }
        
        let url = URL(string: urlString)!
        
        let session = URLSession(configuration: .default)

        let downloadTask = session.dataTask(with: url) { (data, response, error) in

            if let e = error {
                print("Error downoading image: \(e)")
            } else {
                if let _ = response as? HTTPURLResponse {
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self.newsImage.image = image
                        }
                    } else {
                        print("Error, image is nil")
                    }
                } else {
                    print("No resonse")
                }
            }
        }
        
        downloadTask.resume()
        
    }
    
}
