

import SwiftUI

struct ContentView: View {
    @State private var score = 0
    @State private var isOver = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Monaco","Nigeria","Poland","Russia","Spain","UK","US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            LinearGradient(colors: [.indigo,.purple], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess The Flag").font(.largeTitle.weight(.bold)).foregroundColor(.white)
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of").foregroundColor(.white).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).font(.largeTitle.weight(.semibold)).foregroundColor(.mint)
                    }
                    ForEach(0..<3){
                        number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number]).renderingMode(.original).clipShape(Capsule()).shadow(radius: 5)
                        }
                        
                    }
                }
                Spacer()
                Spacer()
                Text("Score \(score)").foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }.padding()
            
        }.alert(scoreTitle, isPresented: $showingScore){
            Button("continue",action: askQuestion)
        } message: {
            Text("your score is \(score)")
        }
        .alert("Congratulations, you won!", isPresented: $isOver){
            Button("restart", action: reset)
        }
        
        
    }
    
    func flagTapped(_ number:Int){
        if(number == correctAnswer){
            scoreTitle = "Correct"
            score += 1
        }
        else{
            scoreTitle = "Wrong. that's the flag of: \(countries[number])"
        }
        showingScore = true
        
    }
    
    func reset(){
        score = 0
        
    }
    
    func askQuestion(){
        
        for i in 0..<8 {
            if (score == 8){
                isOver = true
            }
            else{
                
                countries.shuffle()
                correctAnswer = Int.random(in: 0...2)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
