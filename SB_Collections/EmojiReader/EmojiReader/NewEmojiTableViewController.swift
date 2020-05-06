//
//  NewEmojiTableViewController.swift
//  EmojiReader
//
//  Created by Михаил Дмитриев on 04.05.2020.
//  Copyright © 2020 Mikhail Dmitriev. All rights reserved.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatePrivateButtonState()
        updateUI()
    }
    
    //Проверка на пустой текст
    private func updatePrivateButtonState() {
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    //Назначение значений при загрузке
    private func updateUI() {
        emojiTextField.text = emoji.emoji
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description
    }
    
    
    //Отслеживание изменение текста для блокировки кнопки Save
    @IBAction func textChanged(_ sender: UITextField) {
         updatePrivateButtonState()
    }
    
    //Действия при переходе со второго экрана первый
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Переопределить родительский класс
        super.prepare(for: segue, sender: sender)
        //Если сохраняем
        guard segue.identifier == "saveSegue" else { return }
        
        let emoji = emojiTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, description: description, isFavourite: self.emoji.isFavourite)
    }

}
