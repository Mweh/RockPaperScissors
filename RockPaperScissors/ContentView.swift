//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Muhammad Fahmi on 23/08/23.
//
//your challenge is to make a brain training game that challenges players to win or lose at rock, paper, scissors.
//
//So, very roughly:
//
//Each turn of the game the app will randomly pick either rock, paper, or scissors.
//Each turn the app will alternate between prompting the player to win or lose.
//The player must then tap the correct move to win or lose the game.
//If they are correct they score a point; otherwise they lose a point.
//The game ends after 10 questions, at which point their score is shown.
//So, if the app chose “Rock” and “Win” the player would need to choose “Paper”, but if the app chose “Rock” and “Lose” the player would need to choose “Scissors”.
//

import SwiftUI

struct ContentView: View {
    @State private var pick = ["✊", "✋", "✌️"].shuffled()
    @State private var isWin = Bool.random()
    @State private var computerChoice = ""
    @State private var playerChoice = ""
    @State private var score = 0
    @State private var totalTap = 0
    @State private var isTenQuestion = false
    @State private var totalScore = 0
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.white, .orange], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Section{
                    Text("\(pick[0])")
                        .font(.system(size: 200))
                        .shadow(radius: 10)
                } header: {
                    Text("Computer")
                }
                Spacer()
                Text("Tap the correct move to")
                    .font(.system(size: 30).bold())
                Text("\(isWin ? "Win" : "Lose")")
                    .foregroundStyle(isWin ? .green : .red)
                    .font(.system(size: 80).bold())
                    .shadow(radius: 5)
                Spacer()
                Section{
                    HStack{
                        ForEach(pick, id: \.self){ tap in
                            Button(tap){
                                totalTap += 1
                                
                                scorePoint(playerChoice: tap, computerChoice: pick[0])
                                rePick()
                                reset()
                                print("Player choice: \(pick[0]), Computer choice: \(pick[0])")
                            }
                            .font(.system(size: 100))
                            .shadow(radius: 5)
                            .padding(5)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 5)
                        }
                    }
                    Spacer()
                    Text("Score: \(score)")
                        .font(.system(size: 30).bold())
                } header: {
                    Text("You")
                }
                Spacer()
                Spacer()

            }
        }
        .alert("Your Total score is \(totalScore)", isPresented: $isTenQuestion){
            Button("Restart", action: reset)
        }
    }
    
    func scorePoint(playerChoice: String, computerChoice: String) {
        var playerRock: Bool { playerChoice == "✊" }
        var playerPaper: Bool { playerChoice == "✋" }
        var playerScissors: Bool { playerChoice == "✌️" }
        var computerRock: Bool { computerChoice == "✊" }
        var computerPaper: Bool { computerChoice == "✋" }
        var computerScissors: Bool { computerChoice == "✌️" }
        
        var winPoint: Bool {
            (playerRock && computerScissors) ||
            (playerPaper && computerRock) ||
            (playerScissors && computerPaper)
        }
        var losePoint: Bool {
            (playerScissors && computerRock) ||
            (playerRock && computerPaper) ||
            (playerPaper && computerScissors)
        }
        
        if (isWin && winPoint) || (!isWin && losePoint){
            score += 1
        }
    }
    
    func rePick(){
        pick.shuffle()
        isWin.toggle()
    }
    
    func reset() {
        if totalTap == 10{
            totalScore = score
            isTenQuestion = true
            rePick()
            score = 0
            totalTap = 0
        }
    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
