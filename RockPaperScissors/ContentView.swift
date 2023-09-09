//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Shomil Singh on 30/05/23.
//

import SwiftUI

struct ContentView: View {
    let images = [ Image(systemName: "scissors"),Image(systemName: "newspaper"),Image(systemName: "cricket.ball.circle")]
    let win_or_lose = ["Win","Lose"]
    @State private var computer_choose = Int.random(in: 0...2)
    @State private var choose_against = Int.random(in: 0...1)
    let pieces = ["scissors","paper","rock"]
    @State private var status : Bool = false
    @State private var showing_alert = false
    @State private var alert_title = ""
    @State private var alert_message = ""
    @State private var player_score = 0
    @State private var computer_score = 0
       
    var body: some View {
        ZStack{

            let color1=Color( red: 131/255, green: 96/255, blue: 150/255, opacity: 1)
            let color2=Color( red: 237/255, green: 123/255, blue: 123/255)
            
            let color3=Color( red: 240/255, green: 184/255, blue: 110/255)
            

            RadialGradient(stops: [.init(color: color1, location: 0.30),.init(color: color2, location: 0.30)], center: .top, startRadius: 50, endRadius: 750)

            
            VStack {
               
                HStack{
                    Text("\(win_or_lose[choose_against]) against :")
                        .font(.largeTitle.bold())
                        .foregroundColor(color3)
                        .padding()
                    images[computer_choose]
                        .resizable()
                        .foregroundColor(color3)
                        .frame(width: 50, height: 50)
                        .foregroundColor(color3)
                }
                .padding(.top,90)
                
                .offset(x: 0, y: -100)
                VStack(spacing: 30){
                    ForEach(0..<3){numbers in
                        VStack(){
                            
                            Button{
                                checkinput(numbers)
                                
                            }
                            
                        label:{
                            VStack{
                                images[numbers]
                                    .resizable()
                                    .frame(width: 100,height: 100)
                                    .foregroundColor(color3)
                            }
                            
                        }
//
                        }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                HStack(spacing: 90){
                    VStack{
                        Image(systemName: "figure.run")
                            .resizable()
                            .foregroundColor(color1)
                        Text("\(player_score)")
                            .font(.title3)
                            .foregroundColor(.green)
                        
                    }
                    .frame(width: 40,height: 80)
//                    .background(Color.black)
                    VStack{
                        Image(systemName: "iphone.gen2")
                            .resizable()
                            .foregroundColor(color1)
                        Text("\(computer_score)")
                            .font(.title3)
                            .foregroundColor(.red)
                    }
                    .frame(width: 40,height: 80)
//                    .background(Color.black)
                   
                }
                .offset(y:50)
               
               
                

                
               
                

                
            }
            .alert(alert_title, isPresented: $showing_alert){
                Button("Continue"){
                    playgame()
                }
                
            }message: {
                Text(alert_message)
            }
        }
        .ignoresSafeArea()
       
    }
    func playgame(){
        computer_choose = Int.random(in: 0...2)
        choose_against = Int.random(in: 0...1)
        
    }
    func checkinput(_ input:Int){
        if(computer_choose==0){
            if(input == 2){
                status = true
            }
            else{
                status = false
            }
        }
        if(computer_choose==1){
            if(input==0){
                status = true
            }
            else{
                status=false
            }
        }
        if(computer_choose==2){
            if(input==1){
                status=true
            }
            else{
                status=false
            }
        }
        if(choose_against == 1){
            status.toggle()
        }
        if(status){
            alert_title = "You won"
            player_score+=1
            if(choose_against == 0){
                alert_message = "\(pieces[input]) beats \(pieces[computer_choose])"
                
            }
            else{
                alert_message = "\(pieces[computer_choose]) beats \(pieces[input])"
            }
            
        }
        else{
            alert_title = "You lose"
            computer_score+=1
            if(choose_against == 0){
                alert_message = "\(pieces[computer_choose]) beats \(pieces[input])"
                
            }
            else{
               
                alert_message = "\(pieces[input]) beats \(pieces[computer_choose])"
            }
            
        }
        if(input == computer_choose){
            alert_message = "Its a draw!"
        }
            
        showing_alert=true
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
