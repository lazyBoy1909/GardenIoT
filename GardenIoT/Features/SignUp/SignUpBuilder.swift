//
//  SignUpBuilder.swift
//  GardenIoT
//
//  Created by đào sơn on 05/11/2022.
//

import RIBs

protocol SignUpDependency: Dependency {

}

final class SignUpComponent: Component<SignUpDependency> {
}

// MARK: - Builder

protocol SignUpBuildable: Buildable {
    func build(withListener listener: SignUpListener) -> SignUpRouting
}

final class SignUpBuilder: Builder<SignUpDependency>, SignUpBuildable {

    override init(dependency: SignUpDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SignUpListener) -> SignUpRouting {
        let component = SignUpComponent(dependency: dependency)
        let viewController = SignUpViewController()
        let interactor = SignUpInteractor(presenter: viewController)
        interactor.listener = listener
        return SignUpRouter(interactor: interactor, viewController: viewController)
    }
}
