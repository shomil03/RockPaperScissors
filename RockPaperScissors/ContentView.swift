//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Shomil Singh on 30/05/23.
//  navigation view to make user select game type.
//  game 1-> this.✅
//  game 2-> spontaneous selection of CPU choice.
//  also add chances left option (like game is of 10 chances then new game starts can use stepper for this.
//  also delay pop of of alert box.
//  if user chose wrong button the right button should lit up(green in color with spring animation).😁
//  more animations and transition would make app great.
//  also could use emojis instead of system image
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
    @State private var color_in_frame = false
    @State private var frame_color = Color(.green)
    @State private var countDownTimer = 3
    @State private var Timer_running = true
    @State private var Button_was_tapped = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
       
    var body: some View {
        ZStack{

            let color1=Color( red: 131/255, green: 96/255, blue: 150/255, opacity: 1)
            let color2=Color( red: 237/255, green: 123/255, blue: 123/255)
            
            let color3=Color( red: 240/255, green: 184/255, blue: 110/255)
            let color4=Color( red: 20/255, green: 30/255, blue: 70/255)

            RadialGradient(stops: [.init(color: color1, location: 0.30),.init(color: color2, location: 0.30)], center: .top, startRadius: 50, endRadius: 750)

            
            VStack {
                VStack{
                    
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
//                    .padding(.top,90)
                    
//                    .offset(x: 0, y: -100)
                    
                    Text("\(countDownTimer)")
                        .onReceive(timer){_ in
                            if(countDownTimer>0 ){
                                if(Timer_running){
                                    withAnimation(){
                                        countDownTimer-=1
                                    }
                                }
                            }
                            else{
                                if(Timer_running){
                                    
                                    Timer_running=false
                                    Button_was_tapped = false
                                    time_runs_out()
                                }
                            }
                        }
                        .font(.system(size: 50,weight: .heavy))
                        .foregroundColor(color4)
                        .opacity(countDownTimer == 0 ? 0 : 1)
                        .scaleEffect(countDownTimer == 0 ? 2 : 1)
                    
                        
                }
                
                VStack(spacing: 30){
                    ForEach(0..<3){numbers in
                        VStack(){
                            
                            Button{
                                Button_was_tapped=true
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
                .background(color_in_frame ? frame_color : nil)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                
                HStack(spacing: 120){
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
                .padding(.horizontal)
//                .offset(y:50)
               
               
                

                
               
                

                
            }
           
                .alert(alert_title, isPresented: $showing_alert){
                    Button("Continue"){
                        withAnimation(){
                            playgame()
                        }
                    }
                    
                    
                }message: {
                    Text(alert_message)
                }
                
            }
        .animation(.easeIn, value: frame_color)
        .animation(.easeIn, value: computer_choose)
        .animation(.easeIn, value: choose_against)
        
        
        .ignoresSafeArea()
       
    }
    func time_runs_out(){
        if(!Button_was_tapped){
            if(!Timer_running){
                color_in_frame = true
                frame_color = Color(.red)
                alert_title="Think Quick"
                alert_message="Timer ran out!"
                computer_score+=1
                Timer_running=false
                Button_was_tapped=true
                showing_alert = true
            }
        }
    }
    func playgame(){
        countDownTimer=3
        color_in_frame=false
        Timer_running=true
        computer_choose = Int.random(in: 0...2)
        choose_against = Int.random(in: 0...1)
        
    }
    func checkinput(_ input:Int){
        Timer_running=false
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
            color_in_frame=true
            frame_color = Color(.green)
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
            color_in_frame=true
            frame_color = Color(.red)
            if(choose_against == 0){
                alert_message = "\(pieces[computer_choose]) beats \(pieces[input])"
                
            }
            else{
               
                alert_message = "\(pieces[input]) beats \(pieces[computer_choose])"
            }
            
        }
        if(input == computer_choose){
            alert_title = "You lose"
            alert_message = "Its a draw!"
            frame_color = Color(.red)
            if(choose_against==1){
                player_score-=1
                computer_score+=1
                
            }
        }
            
        showing_alert=true
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
