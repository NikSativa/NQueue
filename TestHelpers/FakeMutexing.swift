import Foundation
import NSpry

import NQueue

final
class FakeMutexing: Mutexing, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case async = "sync(execute:)"
        case trySync = "trySync(execute:)"
    }

    var shouldFireClosures: Bool = false

    func sync<R>(execute work: () throws -> R) rethrows -> R {
        if shouldFireClosures {
            return spryify(fallbackValue: try work())
        }
        return spryify()
    }

    func trySync<R>(execute work: () throws -> R) rethrows -> R {
        if shouldFireClosures {
            return spryify(fallbackValue: try work())
        }
        return spryify()
    }
}
