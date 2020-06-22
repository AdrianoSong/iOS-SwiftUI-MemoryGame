//
//  DebugMenuViewController.swift
//  ___PROJECTNAME___
//
//  Created by Adriano Song on 4/2/20.
//

import SwiftUI

enum DebugOptions: String, CaseIterable {
    case caseTest = "Debug option case test"
}

extension DebugOptions: Identifiable {
    var id: DebugOptions { self }
}


struct DebugMenuView: View {

    let options: [DebugOptions] = DebugOptions.allCases

    var body: some View {
        NavigationView {
            List {
                Section(header: DebugMenuHeader()) {
                    ForEach(options, id: \.self) { option in
                        NavigationLink(destination: self.whereToGo(option: option)) {
                            Text(option.rawValue)
                        }
                    }
                }

            }.listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Debug Menu"))
        }
    }

    /// this function is prepared for more enum options
    func whereToGo(option: DebugOptions) -> some View {
        switch option {
        case .caseTest:
            return AnyView(Text("This is the sample option view"))
        }
    }
}

struct DebugMenuHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "chevron.left.slash.chevron.right")
            Text("Build version: \(getAppBuildVersion())")
        }
    }

    func getAppBuildVersion() -> String {
        return "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")" +
        " - \(Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "")"
    }
}

struct DebugMenuViewController_Previews: PreviewProvider {
    static var previews: some View {
        DebugMenuView()
    }
}
