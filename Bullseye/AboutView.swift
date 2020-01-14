//
//  AboutView.swift
//  Bullseye
//
//  Created by Ashwin Raghuraman on 12/10/19.
//  Copyright © 2019 Ashwin Raghuraman. All rights reserved.
//

import SwiftUI

struct AboutView: View {
  
  struct headingStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 30))
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
  }
  
  struct textViewStyle: ViewModifier {
    func body(content: Content) -> some View {
      return content
        .foregroundColor(Color.black)
        .font(Font.custom("Arial Rounded MT Bold", size: 16))
        .padding(.bottom, 20)
        .padding(.leading, 60)
        .padding(.trailing, 60)
    }
  }
  
  var body: some View {
    Group {
      VStack {
        Text("🎯 BullsEye 🎯").modifier(headingStyle())
        Text("This is BullsEye, the game where you can earn fame by dragging a slider.").modifier(textViewStyle())
        Text("Your goal is to place the slider as close as possible to the target value. The closer you are to the target, the more points you score").modifier(textViewStyle())
        Text("Enjoy!").modifier(textViewStyle())
      }
      .background(Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0))
      .navigationBarTitle("About View")
      }
  .background(Image("Background"))
  }
}

struct AboutView_Previews: PreviewProvider {
  static var previews: some View {
      AboutView().previewLayout(.fixed(width: 896, height: 414))
  }
}
