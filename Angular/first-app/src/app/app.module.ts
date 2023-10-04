import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { HeaderTextComponent } from './header-text/header-text.component';
import { ProductComponent } from './product/product.component';
import { OnOffCircleComponent } from './on-off-circle/on-off-circle.component';
import {HttpClientModule} from '@angular/common/http';
import { CutTextPipe } from './cut-text.pipe'

@NgModule({
  declarations: [
    AppComponent,
    HeaderTextComponent,
    ProductComponent,
    OnOffCircleComponent,
    CutTextPipe
  ],
  imports: [
    BrowserModule,
    HttpClientModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
