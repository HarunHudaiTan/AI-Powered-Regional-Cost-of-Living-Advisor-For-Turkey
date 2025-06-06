import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent {

  constructor(
    private router: Router,
    private authService: AuthService
  ) {}

  viewAnalysis(): void {
    console.log('viewAnalysis called - navigating to /analysis');
    this.router.navigate(['/analysis']);
  }

  editPreferences(): void {
    this.router.navigate(['/preferences']);
  }

  logout(): void {
    this.authService.logout();
    this.router.navigate(['/auth']);
  }
}
