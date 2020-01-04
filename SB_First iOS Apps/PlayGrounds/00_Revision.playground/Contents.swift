import UIKit

//Класс
class Player {
    let name: String
    let game: String
    let age: Int
    
    //Вычисляемое свойство
    var playerInfo: String {
        let playerInfo = """
        Player name is \(name).
        He plays in \(game).
        He is \(age) years old
        """
        return playerInfo
    }
    //Инициализатор
    init(name: String, game: String, age: Int) {
        self.name = name
        self.game = game
        self.age = age
    }
}

//Расширение класса
extension ProfessionalPlayer: PolitePlayer {
    var friends: [Player] {
        return [Player(name: "Kostya", game: "Tennis", age: 25)]
    }
    
    var haveAFriend: Bool {
        return !friends.isEmpty
    }
    
    func smile() {
        print("Let's smile together")
    }
    
    func apologise() -> String {
        print("My apologises")
        return "Sorry Bro"
    }
   
}
//Протокол
protocol PolitePlayer {
    var friends: [Player] { get }
    var haveAFriend: Bool { get }
    
    func smile()
    func apologise() -> String
}

//Наследуемся от класса
class ProfessionalPlayer: Player {
    let experience: Int
    let retirementAge: Int
    
    init(name: String, game: String, age: Int, experience: Int, retirementAge: Int) {
        self.experience = experience
        self.retirementAge = retirementAge
        //Инициализатор суперкласса
        super.init(name: name, game: game, age: age)
    }
}

let footballPlayer = ProfessionalPlayer(name: "Egor", game: "Football", age: 23, experience: 5, retirementAge: 35)
footballPlayer.playerInfo
print(footballPlayer.playerInfo)



