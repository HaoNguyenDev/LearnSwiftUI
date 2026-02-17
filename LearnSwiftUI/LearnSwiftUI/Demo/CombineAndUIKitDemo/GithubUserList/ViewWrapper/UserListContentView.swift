//
//  UserListContentView.swift
//  LearnSwiftUI
//
//  Created by Hao Nguyen on 15/10/25.
//

import SwiftUI

struct UserListContentView: View {
    var body: some View {
        VStack {
            
            GithubUsersViewWrapper()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
