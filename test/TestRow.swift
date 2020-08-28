//
//  ListItem.swift
//  test
//
//  Created by Samuel Resua on 24/08/2020.
//  Copyright © 2020 Samuel Resua. All rights reserved.
//

import SwiftUI

struct TestRow: View {
    
    @Binding var todoTitle: String
    
    var body: some View {
        HStack {
            TextField("Placeholder", text: $todoTitle)
        }
    }
}

struct TestRow_Previews: PreviewProvider {
    static var previews: some View {
        TestRow(todoTitle: .constant("Hello"))
    }
}
