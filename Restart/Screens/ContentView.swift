//
//  ContentView.swift
//  Restart
//
//  Created by Waris on 2022/01/07.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboardingViewActivate: Bool = true
    
    var body: some View {
        ZStack {
            if isOnboardingViewActivate {
            OnboardingView()
        }else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
