//
//  NewsfeedCell.swift
//  VKNewsFeed
//
//  Created by Михаил Дмитриев on 29.05.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit

//Протокол ячейки
protocol FeedCellViewModel {
    var iconUrlString: String {get}
    var name: String {get}
    var date: String {get}
    var text: String? {get}
    var likes: String? {get}
    var comments: String? {get}
    var shares: String? {get}
    var views: String? {get}
}

class NewsfeedCell: UITableViewCell {
    //ID ячейки
    static let reuseID = "NewsfeedCell"
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(viewModel: FeedCellViewModel) {
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
    }
}
