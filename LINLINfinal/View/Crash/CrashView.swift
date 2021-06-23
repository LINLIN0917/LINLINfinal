//
//  CrashView.swift
//  LINLINfinal
//
//  Created by Linlin on 2021/6/2.
//

import SwiftUI

struct CrashView: View {
    func crash() {
        fatalError()
    }
    var body: some View {
        Button(action: {crash()}, label: {
            Text("Crash")
                .font(.system(size: 50))
        })
    }
}

struct CrashView_Previews: PreviewProvider {
    static var previews: some View {
        CrashView()
    }
}
