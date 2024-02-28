//
//  AppFlowCoordinator.swift
//  CleanArchitecture-MVVM
//
//  Created by 유준용 on 2/28/24.
//

import UIKit
// 앱의 화면전환을 담당하는 Coordinator
final class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(
        navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
}

