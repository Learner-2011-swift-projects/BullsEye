//
//  ContentView.swift
//  Bullseye
//
//  Created by Ashwin Raghuraman on 12/3/19.
//  Copyright © 2019 Ashwin Raghuraman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  
  @State var alertIsVisible = false
  @State var sliderValue = 50.0
  @State var target = Int.random(in: 1...100)
  @State var score = 0
  @State var currentRound = 1
  let midnightBlue = Color(red: 0.0/255.0, green: 51.0/255.0, blue: 102.0/255.0)
  
  struct LabelStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
      .foregroundColor(Color.white)
      .modifier(shadowStyle())
      .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }
  
  struct ValueStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
      .foregroundColor(Color.yellow)
      .modifier(shadowStyle())
      .font(Font.custom("Arial Rounded MT Bold", size: 24))
    }
  }
  
  struct ButtonLargeStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
      .foregroundColor(Color.black)
      .font(Font.custom("Arial Rounded MT Bold", size: 18))
    }
  }
  
  struct ButtonSmallStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
      .foregroundColor(Color.black)
      .font(Font.custom("Arial Rounded MT Bold", size: 12))
    }
  }
  
  struct shadowStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
      .shadow(color: Color.black, radius: 5, x: 2, y: 2)
    }
  }
  
  var body: some View {
    VStack {
      Spacer()
      // target row
      HStack {
        Text("Put the bullseye as close as you can to:").modifier(LabelStyle())
        Text("\(target)").modifier(ValueStyle())
      }
      Spacer()
      
      // Slider Row
      HStack {
        Text("1").modifier(LabelStyle())
        Slider(value: $sliderValue, in: 1...100).accentColor(Color.green)
        Text("100").modifier(LabelStyle())
      }
      Spacer()
      
      // Button row
      Button(action: {
        self.alertIsVisible = true
      }) {
        Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/).modifier(ButtonLargeStyle())
      }
      .alert(isPresented: $alertIsVisible) { () -> Alert in
        return Alert(title: Text(alertTitle()),
                     message: Text("Slider's value is \(sliderValueRounded()) \n" +
                      "and you scored \(pointsScoredForCurrentRound()) points"),
                     dismissButton: .default(Text("dismiss me")) {
                      self.score += self.pointsScoredForCurrentRound();
                      self.target = Int.random(in: 1...100)
                      self.currentRound += 1
          })
      }
      .background(Image("Button"), alignment: .center)
      Spacer()
      
      // Result row
      HStack {
        Button(action: {
          self.startOver()
        }) {
          HStack {
            Image("StartOverIcon")
            Text("Start Over").modifier(ButtonSmallStyle())
          }
        }
        .background(Image("Button"), alignment: .center)
        Spacer()
        Text("Score:").modifier(LabelStyle())
        Text("\(score)").modifier(ValueStyle())
        Spacer()
        Text("Round:").modifier(LabelStyle())
        Text("\(currentRound)").modifier(ValueStyle())
        Spacer()
        NavigationLink(destination: AboutView()) {
          HStack {
            Image("InfoIcon")
            Text("Info").modifier(ButtonSmallStyle())
          }
        }
        .background(Image("Button"), alignment: .center)
      }
      Spacer()
    }
    .background(Image("Background"), alignment: .center)
  .accentColor(midnightBlue)
  .navigationBarTitle("BullsEye")
  }
  
  func sliderValueRounded() -> Int {
    Int(sliderValue.rounded())
  }
  
  func amountOff() -> Int {
    abs(sliderValueRounded() - target)
  }
  
  func pointsScoredForCurrentRound() -> Int {
    let amountOffValue = amountOff()
    var pointsScored = 100 - amountOffValue
    if amountOffValue == 0 {
      pointsScored += 100
    } else if amountOffValue <= 1 {
      pointsScored += 50
    }
    return pointsScored
  }
  
  func alertTitle() -> String {
    let difference = amountOff()
    let title: String
    if difference == 0 {
      title = "Perfect!"
    } else if difference <= 5 {
      title = "You almost had it!"
    } else if difference <= 10 {
      title = "Not too bad!"
    } else {
      title = "Are you even trying?"
    }
    return title
  }
  
  func startOver() -> Void{
    score = 0
    currentRound = 0
    sliderValue = 50.0
    target = Int.random(in: 1...100)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().previewLayout(.fixed(width: 896, height: 414))
  }
}
