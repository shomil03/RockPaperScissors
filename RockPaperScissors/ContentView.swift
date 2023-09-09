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
       
    var body: some View {
        VStack {
            HStack{
                Text("\(win_or_lose[choose_against]) against :")
                    .font(.largeTitle.bold())
                    .padding()
                images[computer_choose]
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            VStack{
                HStack{
                    ForEach(0..<3){numbers in
                        Button{
                            checkinput(numbers)
                            
                            
                        }
                    label:{
                        images[numbers]
                            .resizable()
                            .frame(width: 70,height: 100)
                            .padding()
                    }
                        
                        
                        
                    }
                }
            }
            .frame( maxWidth: .infinity, minHeight: 115)
            .background(Color.black)
            .padding()
            
            
            

            
            
            
        }
        .alert(alert_title, isPresented: $showing_alert){
            Button("Continue"){
                playgame()
            }
            
        }message: {
            Text(alert_message)
        }
       
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
            if(choose_against == 0){
                alert_message = "\(pieces[input]) beats \(pieces[computer_choose])"
                
            }
            else{
                alert_message = "\(pieces[computer_choose]) beats \(pieces[input])"
            }
            
        }
        else{
            alert_title = "You lose"
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
