import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-card',
  templateUrl: './card.component.html',
  styleUrls: ['./card.component.css']
})
export class CardComponent {

  @Input() id: number = -1
  @Input() question: string = ""
  @Input() options: string[] = []

  changeQuestion() {
    this.question = "Birdy bird"
  }

}
