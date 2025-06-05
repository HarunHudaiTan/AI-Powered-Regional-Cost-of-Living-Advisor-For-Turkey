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
    // Navigate to analysis page (to be implemented)
    alert('Analysis feature coming soon!');
  }

  editPreferences(): void {
    this.router.navigate(['/preferences']);
  }

  logout(): void {
    this.authService.logout();
    this.router.navigate(['/auth']);
  }
}
