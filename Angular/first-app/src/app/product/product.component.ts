import { Component, Input } from '@angular/core';
import { DisplayModeService } from '../display-mode.service';

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

  isCompact = false

  constructor(private displayMode: DisplayModeService){
    
    this.displayMode.currentCompactStatus.subscribe(

      status => this.isCompact = status

    )
  }
}
