//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Shomil Singh on 30/05/23.
//
//
//  navigation view to make user select game type.
//  game 1-> this.✅
//  game 2-> spontaneous selection of CPU choice.
//  also add chances left option (like game is of 10 chances then new game starts can use stepper for this.
//  also delay pop of of alert box. ✅
//  if user chose wrong button the right button should lit up(green in color with spring animation).😁 ✅
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
    @State private var countDownTimer = 4
    @State private var Timer_running = true
    @State private var Button_was_tapped = false
    @State private var animation_amount : Double = 0
    @State private var Button_tapped = -1
    @State private var correct_ans = -1
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
                    .animation(.easeIn, value: choose_against)
                    .animation(.easeIn, value: computer_choose)
                    Text("\(countDownTimer)")
                        .onReceive(timer){_ in
                            if(countDownTimer>0 ){
                                if(Timer_running){
                                    if(countDownTimer != 4){
                                        withAnimation(){
                                            countDownTimer-=1
                                        }
                                    }
                                    else{
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
                        .opacity((countDownTimer == 0 || countDownTimer == 4) ? 0 : 1)

                   
                    
                        .scaleEffect(countDownTimer == 0 ? 2 : 1)
                    
                }
                
                VStack(spacing: 30){
                    ForEach(0..<3){numbers in
                        VStack(){
                            
                            Button{
                                Button_was_tapped=true
                                Button_tapped = numbers
                                correctAns(numbers: numbers)
                                withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)){
                                    animation_amount+=360
                                }
                                checkinput(numbers)
                                
                            }
                            
                        label:{
                            VStack{
                                images[numbers]
                                    .resizable()
                                    .frame(width: 100,height: 100)
                                    .foregroundColor((!status && Button_was_tapped && numbers != Button_tapped && numbers == correct_ans) ? .green : color3)
                                    
                                    
                                    .scaleEffect((Button_was_tapped && Button_tapped == numbers ) ? 1.25 : 1)
                                    .scaleEffect((Button_was_tapped && Button_tapped != numbers) ? 0.65 : 1)
                                    
                                    .opacity((Button_was_tapped && Button_tapped != numbers) ? 0.5 : 1)
                                    .rotation3DEffect(Angle(degrees: (status && Button_was_tapped  && numbers == Button_tapped ? animation_amount: 0)), axis: (x:0 , y:0.5 , z:0))
                                    .rotation3DEffect(Angle(degrees: (!status && Button_was_tapped && numbers == correct_ans) ? animation_amount : 0), axis: (x:0 , y: 0.5 , z: 0))
                                    .animation(.easeIn(duration: 1),value:Button_tapped)
                                    
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
                .animation(.easeIn(duration: 1), value: color_in_frame)
                
                HStack(spacing: 120){
                    VStack{
                        Image(systemName: "figure.run")
                            .resizable()
                            .foregroundColor(color1)
                        Text("\(player_score)")
                            .font(.title3)
                            .italic()
                            .bold()
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
                            .italic()
                            .bold()
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
                    
                        playgame()
                    
                }
                
                
            }message: {
                Text(alert_message)
            }
            
        }
        
        
        .ignoresSafeArea()
       
    }
    func correctAns(numbers:Int){
        if(choose_against == 0){
            if(computer_choose==0){
                correct_ans = 2
            }
            else if(computer_choose == 1){
                correct_ans = 0
            }
            else{
                correct_ans = 1
            }
        }
        else{
            if(computer_choose==0){
                correct_ans = 1
            }
            else if(computer_choose == 1){
                correct_ans = 2
            }
            else{
                correct_ans = 0
            }
        }
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
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    showing_alert = true
                }
            }
        }
    }
    func playgame(){
        correct_ans = -1
        status = false
        Button_tapped = -1
        Button_was_tapped = false
        countDownTimer=4
        color_in_frame=false
        Timer_running=true
        animation_amount = 0
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
            status = false
            alert_title = "You lose"
            alert_message = "Its a draw!"
            frame_color = Color(.red)
            if(choose_against==1){
                player_score-=1
                computer_score+=1
                
            }
        }
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            showing_alert=true
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
