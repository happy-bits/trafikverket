import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class DisplayModeService {

  private isCompact = new BehaviorSubject<boolean>(false);
  currentCompactStatus = this.isCompact.asObservable();

  changeCompactStatus(status: boolean): void{
    this.isCompact.next(status)  
  }

}
