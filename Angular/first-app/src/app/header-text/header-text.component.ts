import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-header-text',
  templateUrl: './header-text.component.html',
  styleUrls: ['./header-text.component.css']
})
export class HeaderTextComponent {

  @Input() header = '<No header>'
  @Input() description = '<No description>'

  showDetail = true

  toggle() {

    this.showDetail = !this.showDetail
  }

}
