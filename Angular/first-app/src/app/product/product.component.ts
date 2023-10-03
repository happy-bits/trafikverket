import { Component, Input } from '@angular/core';
import { DisplayModeService } from '../display-mode.service';
import { CartService } from '../cart.service';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent {
  @Input() image = 'missing-image.jpg'
  @Input() name = '<No name>'
  @Input() description = '<No description>'
  @Input() isInStock = false
  @Input() id = -1

  amount = 0

  isCompact = false

  constructor(
    private displayMode: DisplayModeService,
    private cartService: CartService
    ) {

    this.displayMode.currentCompactStatus.subscribe(

      status => this.isCompact = status

    )
  }

  adjustAmount(diff: number) {
    this.amount += diff
    this.amount = Math.max(0, this.amount)

    this.cartService.adjustItem(this.id, this.amount)


  }

}
