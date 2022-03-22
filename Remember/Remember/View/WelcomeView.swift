//
//  WelcomeView.swift
//  Remember
//
//  Created by Stu Greenham on 04/02/2022.
//

import SwiftUI

struct WelcomeView: View {
    
    @AppStorage("welcomeScreenShown")
    var welcomeScreenShown: Bool = false
    
    
    var body: some View {
        
        
        //ScrollView {
            VStack(alignment: .center) {

                Spacer()

                // Title
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40, alignment: .center)
                        .accessibility(hidden: true)
                        .padding(20)
                        .background(Color.colorCell.cornerRadius(16))
                        .foregroundColor(.colorBrand)

                    Group {
                        Text("Stop forgeting, start ")
                            //.font(.title)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy) +
                        Text("Remembering")
                            //.font(.title)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(.colorBrand)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.top)
                }
//                .padding(.top, 32)
                
                // Features
                VStack(alignment: .leading) {
                    WelcomeRowDetailView(title: "Simple and Intuitive UI", subTitle: "Capture the things you want to remember, easily.", imageName: "hands.sparkles")

                    WelcomeRowDetailView(title: "Smart Capture", subTitle: "Store additional details to help you find your items faster later.", imageName: "highlighter")

                    WelcomeRowDetailView(title: "Filter and Archive", subTitle: "Filter to what you want to see. When you're done with an item, archive it!", imageName: "line.3.horizontal.decrease.circle")
                }
//                .padding(.horizontal)
                .padding(.top, 24)

                Spacer()

                // Button
                Button(action: {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    welcomeScreenShown = true
                    
                }) {
                    Text("Get Started")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(Color.colorBrand))
                        .padding(.bottom)
//                        .customButton()
                }
            }
            .padding(.horizontal, 24)
        //}
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
