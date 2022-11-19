//
//  HomeBuilder.swift
//  GardenIoT
//
//  Created by đào sơn on 06/11/2022.
//

import RIBs

protocol HomeDependency: Dependency {

}

final class HomeComponent: Component<HomeDependency> {
}

// MARK: - Builder

protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {

    override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeListener) -> HomeRouting {
        let component = HomeComponent(dependency: dependency)
        let viewController = HomeViewController()
        let interactor = HomeInteractor(presenter: viewController)
        interactor.listener = listener
        let profileBuilder = DIContainer.resolve(ProfileBuildable.self, agrument: component)
        return HomeRouter(interactor: interactor,
                          viewController: viewController,
                          profileBuilder: profileBuilder)
    }
}
