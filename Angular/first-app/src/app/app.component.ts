import { Component } from '@angular/core';
import { DisplayModeService } from './display-mode.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'first-app';

  constructor(private displayModeService: DisplayModeService){

  }

  compactView() {
    this.displayModeService.changeCompactStatus(true)
  }
}
