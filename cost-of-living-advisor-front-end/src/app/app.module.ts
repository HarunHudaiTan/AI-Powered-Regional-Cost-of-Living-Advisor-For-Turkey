import { NgModule } from '@angular/core';
import { BrowserModule, provideClientHydration } from '@angular/platform-browser';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './components/login/login.component';
import { SignupComponent } from './components/signup/signup.component';
import { PreferencesComponent } from './components/preferences/preferences.component';
import { AuthFormComponent } from './components/auth-form/auth-form.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { AnalysisComponent } from './components/analysis/analysis.component';
import { CurrencyFormatPipe, NumberFormatPipe } from './pipes/formatting.pipe';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    SignupComponent,
    PreferencesComponent,
    AuthFormComponent,
    DashboardComponent,
    AnalysisComponent,
    NumberFormatPipe,
    CurrencyFormatPipe
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    ReactiveFormsModule,
    HttpClientModule
  ],
  providers: [
    provideClientHydration()
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
