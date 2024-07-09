//
//  ContentView.swift
//  Vibe
//
//  Created by Inzamam on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var identifier = SentimentIdentifier()
    @State private var input = ""
    
    var body: some View {
        ZStack {
            Color("ButtonBg").edgesIgnoringSafeArea(.all)
            VStack  {
                Spacer()
               contentBasedOnInput
                
                TextField("What are you thinking?", text: $input)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color("ButtonBg"))
                            .frame(width: 350, height: 70)
                            .shadow(color: Color("Buttondarkshadowcolor"), radius: 5, x: -10, y: -10)
                            .shadow(color: Color("Buttonlightshadow"), radius: 5, x: 10, y: 10)
                    )
                    .keyboardType(.default) // Ensure default keyboard type
                    .onTapGesture {
                                    // Optional: You can handle focus explicitly if needed
                                    UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                                }
                    .onChange(of: input) { _ in
                        if input.isEmpty || input.last == " " {
                            self.identifier.predict(input)
                        }
                        
                    }
                    .padding(.top, 20)
                Spacer()
            }.padding()
        }
        
    }
    
    @ViewBuilder
    private var contentBasedOnInput: some View {
        switch input.lowercased() {
        case "taylor":
            Image("taylor")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity, height: .infinity)
                .padding(.all, -20)
                .padding(.bottom, 60)
        case "7":
            Image("Dhoni")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .infinity, height: .infinity)
                .padding(-40)
            
            Text("Thala for a reason!")
                .font(.title)
                .foregroundColor(.yellow)
                .background(.black)
                .padding()
                .padding(.bottom, 20)
            
        default:
            Text(getEmojiForPrediction(prediction: identifier.prediction))
                .font(.system(size: 60))
                .opacity(identifier.confidence)
                .scaleEffect(CGFloat(1 + (identifier.confidence - 0.5)))
                .animation(.spring())
        }
    }
    
    // Function to determine emoji based on prediction
    private func getEmojiForPrediction(prediction: String) -> String {
        switch prediction {
        case "negative":
            return "😠"
        case "neutral":
            return "😐"
        case "positive":
            return "☺️"
        default:
            return "😐"
        }
    }
}

#Preview {
    ContentView()
}
