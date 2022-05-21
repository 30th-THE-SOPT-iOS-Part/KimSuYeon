//
//  Coordinator.swift
//  30th-Assignment
//
//  Created by 김수연 on 2022/05/19.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    // 코디네이터가 화면 전환을 위해 가지고 있는 네비게이션 컨트롤러 !
    var presenter: UINavigationController { get set }
    // 자식 코디네이터들을 담을 배열
    var childCoordinators: [Coordinator] { get set }
    // 자식 코디네이터들을 생성하고 제거하는 부모코디네이터
    var parentCoordinator: Coordinator? { get set }
}

extension Coordinator {

    // 화면 전환스타일에 따라 구현해놓은 메서드
    func transition(to coordinator: Coordinator,
                    with viewController: UIViewController,
                    using style: TransitionStyle,
                    animated: Bool = false,
                    completion: (() -> Void)? = nil) {

        switch style {
        case .root:
            // root를 재설정해주고 이동하는 transition
            presenter = UINavigationController(rootViewController: viewController)
            let scene = UIApplication.shared.connectedScenes.first
            if let sceneDelegate: SceneDelegate = scene?.delegate as? SceneDelegate {
                sceneDelegate.window?.rootViewController = presenter
            }
            // 음 어떤 코디네이터로 root설정을 하므로 돌아가므로 원래 자식 코디네이터들 전부 삭제 ~
            removeChildCoordinators()
            // 돌아간 코디네이터를 자식 코디네이터에 추가 - 이건 잘 모르겠음
            addChildCoordinator(coordinator)
        case .push:
            // push해서 이동할 코디네이터를 자식코디네이터로 추가
            addChildCoordinator(coordinator)
            // navigation push
            presenter.pushViewController(viewController, animated: animated)
        case .modal:
            // present할 코디네이터를 자식 코디네이터로 추가
            addChildCoordinator(coordinator)
            // present ! 
            presenter.present(viewController, animated: animated, completion: completion)
        }
    }

    /// 자식 코디네이터가 할일을 끝냈을 때 호출
    /// : 자신의 부모코디네이터에 접근해서 자기 자신을 자식코디네이터 배열에서 지워줌
    /// 보통 viewDidDisappear 에서 호출 ! 화면이 사라질 시점 !
    /// or NavigationController Delegate의 didShow() 메서드에서 호출
    func didFinishChildCoordinator() {
        parentCoordinator?.removeChildCoordinator(self)
    }

    // 자식 코디네이터를 추가하는 메서드 : 부모에서 이동할 코디네이터를 자식으로 추가해서 관리 !
    func addChildCoordinator(_ childCoordinator: Coordinator) {
        self.childCoordinators.append(childCoordinator)
    }

    /// 자식 코디네이터를 지우는 메서드
    /// 예를 들어 어떤 VC에서 첫화면으로 돌아간다면 ? parent coordinator한테 알린다음에
    /// childcoordinator 배열에서 VC들을  지워야합니다
    /// 위에 보면 didFinsh ~ 메서드 내부에서 호출해주는데 , 부모 코디네이터에 접근해서 자식을 지워줍니다 ~~
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        /// === 는 클래스의 두 인스턴스가 동일한 메모리를 가리키는지 점검하는 연산자 이므로
        /// 코디네이터 프로토콜을 클래스 전용 프로토콜로 만들자 !!
        /// 내가 이해한 바로는 받은 파라미터로 받은 childCoordinator랑 동일 메모리를 가지는 그 코디네이터를 찾아서
        /// 인덱스를 반환해주는것 같다 !
        if let index = childCoordinators.firstIndex(where: { $0 === childCoordinator }) {
            childCoordinators.remove(at: index)
        }
    }

    func removeChildCoordinators() {
        /// 따로 파라미터를 받는게 아니라 전부 삭제
        childCoordinators.forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }
}
