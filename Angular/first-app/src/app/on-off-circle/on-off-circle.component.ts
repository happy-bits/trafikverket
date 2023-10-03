import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-on-off-circle',
  templateUrl: './on-off-circle.component.html',
  styleUrls: ['./on-off-circle.component.css']
})
export class OnOffCircleComponent {

  @Input() isOn = false

}
