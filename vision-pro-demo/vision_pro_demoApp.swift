//
//  vision_pro_demoApp.swift
//  vision-pro-demo
//
//  Created by Yuhang on 2024/5/24.
//

import SwiftUI

@main
struct vision_pro_demoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ModelAnimation") {
            ModelAnimation()
        }
    }
}
