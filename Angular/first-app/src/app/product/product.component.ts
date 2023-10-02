import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent {
  @Input() image = 'missing-image.jpg'
  @Input() name = '<No name>'
  @Input() description = '<No description>'
}
