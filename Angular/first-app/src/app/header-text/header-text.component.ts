import { Component, Input } from '@angular/core';
import { DisplayModeService } from '../display-mode.service';

@Component({
  selector: 'app-header-text',
  templateUrl: './header-text.component.html',
  styleUrls: ['./header-text.component.css']
})
export class HeaderTextComponent {

  @Input() header = '<No header>'
  @Input() description = '<No description>'

  isCompact = false

  constructor(private displayMode: DisplayModeService){
    
    this.displayMode.currentCompactStatus.subscribe(

      status => this.isCompact = status

    )
  }

  toggle() {
    this.isCompact = !this.isCompact
  }

}
