//
//  HomeView.swift
//  Restart
//
//  Created by Waris on 2022/01/11.
//

import SwiftUI

struct HomeView: View {
    // mark: - property
    
    @AppStorage("onboarding") var isOnboardingViewActivate:  Bool = false
    @State private var isAnimating:  Bool = false
    
    //mark - body
    
    var body: some View {
        VStack(spacing:  20) {
           
            
             // mark : header
            
            Spacer()
            
            
            ZStack  {
                
                CircleGroupView(ShapeColor:  .gray, ShapeOpacity:  0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 :  -35)
                    .animation(
                        Animation
                            .easeInOut(duration:  4)
                            .repeatForever(),
                            value: isAnimating
                    )
            }
            
            
            // mark : - center
            
            Text("نادانغا يېقىنلاشما،ئەي ئاق كۆڭۇل ،دىققەت قىلغىنكى ،ئاق نەرسىگە قارا تېز يۇقىدۇ.")
                .font(.custom("UKIJ Tuz Tom", size: 20))
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            
            // mark : footer
            
            Spacer()
            
            
            Button(action : {
                withAnimation {
                    playSound(sound: "dil_kvyi", type: "mp3")
                    isOnboardingViewActivate = true
                }
            }) {
                
                Image(systemName:  "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                
                Text("قايتا باشلاش")
                    .font(.custom("UKIJ Tuz Tom", size: 20))
                    .fontWeight(.bold)
            } // : button
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            
            
        } //: VSTACK
        .onAppear(perform:  {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 , execute:  {
                isAnimating = true
            })
        })
    }
    
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            
    }
}
