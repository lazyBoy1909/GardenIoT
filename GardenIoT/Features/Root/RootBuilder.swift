//
//  RootBuilder.swift
//  GardenIoT
//
//  Created by đào sơn on 01/11/2022.
//

import RIBs

protocol RootDependency: Dependency {
    var window: UIWindow { get }
}

final class RootComponent: Component<RootDependency> {
    var window: UIWindow

    init(dependency: RootDependency, window: UIWindow) {
        self.window = window
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> RootRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> RootRouting {
        let component = RootComponent(dependency: dependency, window: dependency.window)
        let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        let splashBuilder = DIContainer.resolve(SplashBuildable.self, agrument: component)
        return RootRouter(interactor: interactor,
                          viewController: viewController,
                          window: dependency.window,
                          splashBuilder: splashBuilder)
    }
}