
@testable import NyBestArticles
import Nimble
import Quick
import RxSwift
import Swinject
import XCTest

class ViewControllerTest: QuickSpec {
    override func spec() {
        let container = setupDependencies()

        describe("ArticlesListVC") {
            describe("viewDidLoad") {
                let vc = LeakTest {
                    container.resolveViewController(ArticlesListVC.self)
                }

                it("must not leak") {
                    expect(vc).toNot(leak())
                }
            }
        }
    }
}
