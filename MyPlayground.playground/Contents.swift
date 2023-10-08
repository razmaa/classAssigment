import Foundation

// პირველი

class Book {
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String, isBorrowed: Bool) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    
    func markAsBorrowed() {
        isBorrowed = true
    }
    
    func markAsReturned() {
        isBorrowed = false
    }
}

class Owner {
    var ownerId: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(ownerId: Int, name: String, borrowedBooks: [Book] = []) {
        self.ownerId = ownerId
        self.name = name
        self.borrowedBooks = borrowedBooks
    }
    
    func borrowBook(_ book: Book) {
        if !book.isBorrowed {
            book.markAsBorrowed()
            borrowedBooks.append(book)
        } else {
            print("\(name) cannot borrow '\(book.title)' as it is already borrowed.")
        }
        
    }
    
    func returnBook(_ book: Book){
        if let index = borrowedBooks.firstIndex(where: { $0.bookID == book.bookID }) {
            borrowedBooks.remove(at: index)
            book.markAsReturned()
        } else {
            print("\(name) cannot return '\(book.title)' as it was not borrowed by them.")
        }
    }
}

class Library {
    var books: [Book]
    var owners: [Owner]
    
    init(books: [Book] = [], owners: [Owner] = []) {
        self.books = books
        self.owners = owners
    }
    
    func addBook(_ book: Book) {
        books.append(book)
    }
    
    func addOwner(_ owner: Owner) {
        owners.append(owner)
    }
    
    func availableBooks() -> [Book] {
        var availableBooks: [Book] = []
        for book in books {
            if !book.isBorrowed {
                availableBooks.append(book)
            }
        }
        return availableBooks
    }
    
    func takenBooks() -> [Book] {
        var takenBooks: [Book] = []
        for book in books {
            if book.isBorrowed {
                takenBooks.append(book)
            }
        }
        return takenBooks
    }
    
    func findOwner(ownerID: Int) -> Owner? {
        for owner in owners {
            if owner.ownerId == ownerID {
                return owner
            }
        }
        return nil
    }
    
    func findBook(owner: Owner) -> [Book] {
        owner.borrowedBooks
    }
    
    func takeBook(owner: Owner, book: Book) {
        if !book.isBorrowed {
            owner.borrowBook(book)
        }
    }
}

let book1 = Book(bookID: 1, title: "Vepkhistkaosani", author: "Shota Rustaveli", isBorrowed: false)
let book2 = Book(bookID: 2, title: "Aluda Ketelauri", author: "Vaja Pshavela", isBorrowed: false)
let book3 = Book(bookID: 3, title: "The Master and Margarita", author: "Mikhail Bulgakov", isBorrowed: false)
let book4 = Book(bookID: 4, title: "Adventures of Huckleberry Finn", author: "Mark Twain", isBorrowed: false)
let book5 = Book(bookID: 5, title: "The Adventures of Tom Sawyer", author: "Mark Twain", isBorrowed: false)

let owner1 = Owner(ownerId: 1, name: "Nika")
let owner2 = Owner(ownerId: 2, name: "Luka")
let owner3 = Owner(ownerId: 3, name: "Nata")

let myLibrary = Library()

myLibrary.addBook(book1)
myLibrary.addBook(book2)
myLibrary.addBook(book3)
myLibrary.addBook(book4)
myLibrary.addBook(book5)
myLibrary.addOwner(owner1)
myLibrary.addOwner(owner2)
myLibrary.addOwner(owner3)

myLibrary.takeBook(owner: owner1, book: book5)
myLibrary.takeBook(owner: owner2, book: book1)
myLibrary.takeBook(owner: owner2, book: book3)
myLibrary.takeBook(owner: owner1, book: book2)
myLibrary.takeBook(owner: owner3, book: book4)

owner2.returnBook(book1)
owner2.returnBook(book3)


func infoAboutLibrary(library: Library) {
    print("\n")
    print("Borrowed Books:", "\n")
    for book in myLibrary.takenBooks() {
        print(book.title)
        print("------------------------")
    }
    print("\n")
    print("Available Books:", "\n")
    for book in library.availableBooks() {
        print(book.title)
        print("------------------------")
    }
}

func infoAboutOwner(owner: Owner) {
    print("\n")
    print("\(owner.name) borrowed those books:", "\n")
    for book in owner.borrowedBooks {
        print(book.title)
        print("------------------------")
    }
}

infoAboutLibrary(library: myLibrary)
infoAboutOwner(owner: owner1)
infoAboutOwner(owner: owner3)

// მეორე

class Product {
    let productID: Int
    let name: String
    var price: Double
    
    init(productID: Int, name: String, price: Double) {
        self.productID = productID
        self.name = name
        self.price = price
    }
}

class Cart {
    let cartID: Int
    var items: [Product]
    
    init(cartID: Int, items: [Product] = []) {
        self.cartID = cartID
        self.items = items
    }
    
    func addItemToCart(_ product: Product) {
        items.append(product)
    }
    
    func removeItemFromCart(productID: Int) {
        if let index = items.firstIndex(where: {$0.productID == productID}){
            items.remove(at: index)
        }
    }
    
    func total() -> Double {
        var total = 0.0
        
        for item in items {
            total += item.price
        }
        return total
    }
}

class User {
    let userID: Int
    let username: String
    var cart: Cart
    
    init(userID: Int, username: String, cart: Cart) {
        self.userID = userID
        self.username = username
        self.cart = cart
    }
    
    
    func addItemToCart(_ product: Product) {
        cart.addItemToCart(product)
    }
    
    func removeItemFromCart(_ product: Product) {
        cart.removeItemFromCart(productID: product.productID)
    }
    
    func checkout() {
        cart.total()
        cart.items.removeAll()
    }
}


var product1 = Product(productID: 1, name: "Extension for using spaces correctly", price: 12.3)
var product2 = Product(productID: 2, name: "Coffe", price: 2.5)
var product3 = Product(productID: 3, name: "Glasses", price: 160)
var product4 = Product(productID: 4, name: "Mouse", price: 48.9)
var product5 = Product(productID: 5, name: "Keyboard", price: 29.8)

var cart1 = Cart(cartID: 1, items: [])
var cart2 = Cart(cartID: 2, items: [])

var user1 = User(userID: 1, username: "Razma", cart: cart1)
var user2 = User(userID: 2, username: "Azmar", cart: cart2)


cart1.addItemToCart(product1)
cart1.addItemToCart(product4)
cart2.addItemToCart(product3)
cart2.addItemToCart(product2)

func pricesOfItemsInCart(cart: Cart) {
    print("\n")
    print("Your cart's ID is: \(cart.cartID)")
    for item in cart.items {
        print("Price of \(item.name) is \(item.price)")
    }
    print("Your total is: \(cart.total())")
    print("----------------------")
}
pricesOfItemsInCart(cart: cart1)
pricesOfItemsInCart(cart: cart2)

func checkout(user: User) {
    print("\n")
    print("Your total is: \(user.cart.total())")
    user.checkout()
    print("We received your order, Thank you for choosing us")
    print("Estimated delivery time: 2 days")
}

checkout(user: user1)
checkout(user: user2)














