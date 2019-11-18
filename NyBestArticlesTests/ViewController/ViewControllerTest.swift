
@testable import Articly
import Nimble
import Quick
import Swinject

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
        
        describe("ArticleDetailVC") {
                  describe("viewDidLoad") {
                      let vc = LeakTest {
                          container.resolveViewController(ArticleDetailVC.self)
                      }

                      it("must not leak") {
                          expect(vc).toNot(leak())
                      }
                  }
              }
        
        describe("ArticleDetailVC") {
               var sut: ArticleDetailVC!

               beforeEach {
                   sut = container.resolveViewController(ArticleDetailVC.self)
                   _ = sut.view
               }

               context("when view is loaded") {
                   it("detail loaded") {
                    
                    expect(sut.labelTitle.text).to(equal("I Was the Fastest Girl in America, Until I Joined Nike"))
                    expect(sut.labelAbstract.text).to(equal("Mary Cain’s male coaches were convinced she had to get “thinner, and thinner, and thinner.” Then her body started breaking down."))
                    expect(sut.labelByLine.text).to(equal("By MARY CAIN"))
                   }
               }
           }
    }
}
