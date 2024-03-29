import { Component } from '@angular/core';
import { DisplayModeService } from './display-mode.service';
import { CartService } from './cart.service';
import { IProduct } from './product';
import { ProductService } from './product.service';
import { ICartItem } from './cart-item';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'first-app';

  products: IProduct[] = [];

  currentDate = new Date();

  constructor(
    private displayModeService: DisplayModeService,
    private cartService: CartService,
    private productService: ProductService
    ){

  }

  ngOnInit() {
    this.productService.getProducts().subscribe( data => {
      this.products = data
    })
  }

  compactView() {
    this.displayModeService.changeCompactStatus(true)
  }

  expandedView() {
    this.displayModeService.changeCompactStatus(false)
  }

  cartItems(): ICartItem  []{
    return this.cartService.getCartItems()
  }

  getProductName(id: number) {
    const product = this.products.find( p => p.id === id)

    return product === undefined ? "Missing name" : product.name

  }

}


