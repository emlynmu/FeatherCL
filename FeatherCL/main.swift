//
//  main.swift
//  FeatherCL
//
//  Created by Emlyn Murphy on 10/30/21.
//

import Foundation
import FeatherKit
import Combine

var cancellable = [AnyCancellable]()

Authentication.default.requestTokenPublisher().sink { completion in
    switch completion {
    case .finished:
        print("finished")
    case .failure(let error):
        print("error: \(error)")
    }

    cancellable.removeAll()
} receiveValue: { token in
    print("got token: \(token)")

    guard let authorizeURL = URL.Provider.default.authorize(oauthToken: token.oauthToken) else {
        print("Couldn't get URL")
        return
    }

    print("authorize URL: \(authorizeURL)")
}.store(in: &cancellable)

let isAuth = Authentication.default.isAuthenticated
print("isAuth: \(isAuth)")

while(cancellable.count > 0) { }

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}
