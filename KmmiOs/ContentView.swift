//
//  ContentView.swift
//  KmmiOs
//
//  Created by Akhil.b on 13/10/23.
//

import SwiftUI
import shared

struct ContentView: View {
    
    // The observed object property wrapper is used to subscribe to the view model.
    @ObservedObject private (set) var viewModel:ViewModel
    
    var body: some View {
        NavigationView{
            listView()
                .navigationBarTitle("SpaceX Launches")
                .navigationBarItems(trailing: Button("Reload"){
                    self.viewModel.loadLaunches(forceReload: true)
                })
        }
    }
    
    private func listView()->AnyView{
        switch viewModel.launches{
        case.loading:
            return AnyView(Text("Loading...").multilineTextAlignment(.center))
        case.result(let launches):
            return AnyView(List(launches){
                launch in RocketLaunchRow(rocketLaunch: launch)
            })
        case.error(let description):
            return AnyView(Text(description).multilineTextAlignment(.center))
        }
    }
}

/**
 * Extension of ContentView which contains the status of launches as enum LoadableLaunches and the view model.
 */
extension ContentView{
    enum LoadableLaunches{
        case loading
        case result([RocketLaunch])
        case error(String)
    }
    
    /**
     * This is the ViewModel class for the ContentView, which will prepare and manage the data.  ContentView.ViewModel is declared as an ObservableObject
     * and @Published wrapper is used for the launches property, so the view model will emits signals whenever the property changes.
     * @Function loadLaunches retrieves the data about rocket launches by using the instance of SpaceXSDK
     */
    @MainActor
    class ViewModel:ObservableObject{
        let sdk:SpaceXSDK
        @Published var launches = LoadableLaunches.loading
        
        init(sdk: SpaceXSDK) {
            self.sdk = sdk
        }
        
        /**
         * It retreives the data and store the result in launches property
         * When you compile a Kotlin module into an Apple framework, suspending functions are available in it as Swift's async / await mechanism.
         * Since the getLaunches function is marked with the @Throws(Exception::class) annotation, any exceptions that are instances of the
         * Exception class or its subclass will be propagated as NSError. Therefore, all such errors can be caught by the loadLaunches() function.
         */
        func loadLaunches(forceReload:Bool){
            Task{
                do{
                    self.launches = .loading
                    let launches = try await sdk.getLaunches(forceReload: forceReload)
                    self.launches = .result(launches)
                }catch{
                    self.launches = .error(error.localizedDescription)
                }
            }
        }
    }
}

/**
 * To make it compile, the RocketLaunch class needs to confirm the Identifiable protocol, as it is used as a parameter for initializing the List Swift UIView.
 */
extension RocketLaunch:Identifiable{ }
