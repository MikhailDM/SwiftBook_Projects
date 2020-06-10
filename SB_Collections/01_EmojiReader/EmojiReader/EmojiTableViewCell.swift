//
//  EmojiTableViewCell.swift
//  EmojiReader
//
//  Created by Михаил Дмитриев on 04.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //Вызываетса когда ячейка прогрузиться
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //Функция настройки ячейки
    func set(object: Emoji) {
        self.emojiLabel.text = object.emoji
        self.nameLabel.text = object.name
        self.descriptionLabel.text = object.description
    }
}
