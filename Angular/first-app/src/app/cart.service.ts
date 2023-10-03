import { Injectable } from '@angular/core';
import { ICartItem } from './cart-item';

@Injectable({
  providedIn: 'root'
})

export class CartService {
  
  private cart: ICartItem[] = [];

  adjustItem(productId: number, amount: number): void {
    const productIndex = this.cart.findIndex(item => item.id === productId);
  
    const productExistInCart = productIndex > -1

    if (amount === 0) {
      // If amount is 0, remove the item from the cart
      if (productExistInCart) {
        this.cart.splice(productIndex, 1);
      }

    } else {

      // If amount is greater than 0, add or update the item in the cart
      if (productExistInCart) {
        this.cart[productIndex].amount = amount;
      } else {
        this.cart.push({ id: productId, amount: amount });
      }
    }
  }

  getCartItems(): ICartItem[] {
    return this.cart;
  }
}