import UIKit

//var inputS = "funnnnnny efunrfal funfair"
//var inputS = "ABACDAQ BACDAQA ACDAQAW XYZCDAQ"

var inputS = "SoloLearn Learning LearningIsFun Learnable"

var inputArr = inputS.split(separator: " ")
var firstWordA = Array(inputArr[0])
//var secondWordA = Array(inputArr[1])
//var q = 0
var maxSub = ""
var maxSubArr = [String]()
var temp = ""

for q in 1..<inputArr.count {
    let secondWordA = Array(inputArr[q])
    maxSub = ""
    //Перебираем все буквы в первом слове. Так как повторяющиеся части есть во всех словах
    for i in 0..<firstWordA.count {
    //    guard q < inputS.count  else {break}
    //    q += 1
        
        for j in 0..<secondWordA.count {
            //Сравниваем буквы
            if firstWordA[i] == secondWordA[j] {
                //Сравнение дальнейших символов
                var t = j
                temp = ""
                for k in i..<firstWordA.count {
                    //Проверка на OutOfRange
                    guard t != secondWordA.count else {break}
                    if firstWordA[k] == secondWordA[t] {
                        temp += String(firstWordA[k])
                        t += 1
                        //print("Temp " + temp)
                    } else {
                        break
                    }
                    //Проверка ответа
                    if temp.count > maxSub.count {
                        maxSub = temp
                        //print("Присвоение " + maxSub)
                    }
                }
            }
        }
        
    }
    maxSubArr.append(maxSub)
}
//Окончательный ответ
var finallyAnswer = ""
var shortestIndex  = 9999
for answer in maxSubArr {
    var length = answer.count
    if length < shortestIndex {
        finallyAnswer = String(answer)
        //print(maxSubArr[shortestIndex])
    }
}
print(finallyAnswer)
