//
//  Tabs.swift
//  test
//
//  Created by Samuel Resua on 24/08/2020.
//  Copyright © 2020 Samuel Resua. All rights reserved.
//

import SwiftUI

struct Tabs: View {
    var body: some View {
        TabView {
           Text("The content of the first view")
             .tabItem {
                Image(systemName: "phone.fill")
                Text("First Tab")
              }
        }    }
}

struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}
