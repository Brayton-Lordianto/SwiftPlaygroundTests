import UIKit
import Combine

class viewModel {
    private let usernamesStore = CurrentValueSubject<[String], Never>(["Bill"])
    var usernames: AnyPublisher<[String], Never>
    
    let userPassed = PassthroughSubject<String, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        usernames = usernamesStore.eraseToAnyPublisher()
        
        userPassed.sink { [unowned self] toAdd in
            self.usernamesStore.send(usernamesStore.value + [toAdd])
        }.store(in: &subscriptions)
        
        usernames.sink { val in
            print("usernames changed to \(val)")
        }.store(in: &subscriptions)
    }
    
    
}


let vm = viewModel()
vm.userPassed.send("Jack")
