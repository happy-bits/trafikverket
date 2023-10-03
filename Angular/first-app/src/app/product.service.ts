import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { IProduct } from './product';

@Injectable({
  providedIn: 'root'
})
export class ProductService {

  private productsUrl = 'assets/products.json'
  constructor(
    private http: HttpClient

  ) { }

  getProducts() {
    return this.http.get<IProduct[]>(this.productsUrl)
  }
}
