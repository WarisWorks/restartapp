//
//  OnboardingView.swift
//  Restart
//
//  Created by Waris on 2022/01/11.
//

import SwiftUI

struct OnboardingView: View {
    // mark: - property
    
    @AppStorage("onboarding")  var isOnboardingViewActive:  Bool = true
    
    
    @State private var buttonWidhth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating:  Bool = false
    @State private var imageOffset: CGSize =  .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "ئەي ئوغۇل"
    
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    // Mark: - body
    
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges:  .all)
            
            VStack (spacing: 20)  {
                  // Mark: - header
                    
                Spacer()
                
                VStack(spacing: 0) {
                    Text(textTitle)
                        .font(.custom("UKIJ Tuz Tom", size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                        .padding()
                    
                    
                    Text("""
          نادانلارنىڭ سۆھبىتىنى ئىختىيار قىلما ،
         ئۇ سېنى ئاقىۋەت خارۇ - زار قىلغۇسىدۇر.
         """)
                        .font(.custom("UKIJ Tuz Tom", size: 20))
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                } //: header
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 :  -40)
                .animation(.easeOut(duration: 1),  value: isAnimating)
                
                    // Mark : center
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity:  0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1 ), value: imageOffset)
              
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimating)
                        .offset(x: imageOffset.width *  1.2,  y:  0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        if abs(imageOffset.width)  <=  150 {
                                            imageOffset = gesture.translation
                                            
                                            withAnimation(.linear(duration:  0.25)) {
                                                indicatorOpacity = 0
                                                textTitle = "نەسىھەتىم"
                                                   
                                            }
                                            
                                        }
                                    }
                                    .onEnded { _ in
                                        imageOffset = .zero
                                        
                                        withAnimation(.linear(duration:  0.25)) {
                                            indicatorOpacity = 1
                                            textTitle =  "قۇلاق سال"
                                               
                                        }
                                    }
                                
                        ) //: Gesture
                        
                        .animation(.easeOut(duration: 1), value: imageOffset)
                        
                }// : center
                .overlay(
                    Image(systemName:  "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y: 20)
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration:  1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                    , alignment:   .bottom
                )
                
                Spacer()
                    
                    
                    //mark:  -footer
                ZStack {
                        // parts of the custom button
                    
                        
                        // 1. background *(static)
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
                    
                        // 2. call 0 to action (static)
                    
                    Text  ("قايتا باشلاڭ")
                        .font(.custom("UKIJ Tuz Tom", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor( .white)
                        .offset(x: 20)
                    
                    
                        //3. capsule
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorBlue"))
                            .frame(width:  buttonOffset + 80)
                        
                        Spacer()
                    } //: hstack
                    
                        //4. circle (draggable)
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorDarkBlue"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName:  "chevron.right.2")
                                .font(.system(size: 24, weight:  .bold))
                            
                        }
                        .foregroundColor(.white)
                        .frame(width:  80, height:  80, alignment:  .center)
                        .offset(x: buttonOffset)
                        .offset(x: 0)
                        .gesture(
                            DragGesture()
                                .onChanged {  gesture in
                                    if gesture.translation.width > 0  && buttonOffset <=
                                    buttonWidhth - 80 {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded {  _ in
                                    withAnimation(Animation.easeOut(duration: 0.4)) {
                                        if buttonOffset > buttonWidhth / 2 {
                                            hapticFeedback.notificationOccurred(.success)
                                            playSound(sound: "dil_kvyi", type: "mp3")
                                            buttonOffset = buttonWidhth - 80
                                            isOnboardingViewActive = false
                                        } else {
                                            hapticFeedback.notificationOccurred(.warning)
                                            buttonOffset = 0
                                        }
                                        
                                    }
                                }
                            )   //: GESTURE
                        
                        Spacer()
                    } // : hstack
                }//: footer
                .frame(width:  buttonWidhth, height:  80,   alignment:  .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }// Vstack
        } //: ZStack
        .onAppear(perform:  { 
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
