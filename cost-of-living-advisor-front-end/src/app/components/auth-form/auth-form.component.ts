import { Component } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-auth-form',
  templateUrl: './auth-form.component.html',
  styleUrls: ['./auth-form.component.css']
})
export class AuthFormComponent {
  isLoginMode = true;
  authForm: FormGroup;
  loading = false;
  error = '';

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router
  ) {
    this.authForm = this.createForm();
  }

  createForm(): FormGroup {
    return this.fb.group({
      username: ['', [Validators.required, Validators.minLength(3)]],
      email: ['', [Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6)]],
      confirmPassword: ['']
    });
  }

  switchMode(): void {
    this.isLoginMode = !this.isLoginMode;
    this.error = '';
    
    if (this.isLoginMode) {
      // Login mode - email and confirmPassword not required
      this.authForm.get('email')?.clearValidators();
      this.authForm.get('confirmPassword')?.clearValidators();
    } else {
      // Signup mode - email and confirmPassword required
      this.authForm.get('email')?.setValidators([Validators.required, Validators.email]);
      this.authForm.get('confirmPassword')?.setValidators([Validators.required]);
    }
    
    this.authForm.get('email')?.updateValueAndValidity();
    this.authForm.get('confirmPassword')?.updateValueAndValidity();
  }

  onSubmit(): void {
    if (this.authForm.invalid) {
      return;
    }

    if (!this.isLoginMode) {
      const password = this.authForm.get('password')?.value;
      const confirmPassword = this.authForm.get('confirmPassword')?.value;
      
      if (password !== confirmPassword) {
        this.error = 'Passwords do not match';
        return;
      }
    }

    this.loading = true;
    this.error = '';

    if (this.isLoginMode) {
      this.login();
    } else {
      this.signup();
    }
  }

  private login(): void {
    const credentials = {
      username: this.authForm.get('username')?.value,
      password: this.authForm.get('password')?.value
    };

    this.authService.login(credentials).subscribe({
      next: (response) => {
        this.loading = false;
        this.router.navigate(['/preferences']);
      },
      error: (error) => {
        this.loading = false;
        this.error = error.error?.msg || 'Login failed. Please try again.';
      }
    });
  }

  private signup(): void {
    const userData = {
      username: this.authForm.get('username')?.value,
      email: this.authForm.get('email')?.value,
      password: this.authForm.get('password')?.value
    };

    this.authService.signup(userData).subscribe({
      next: (response) => {
        this.loading = false;
        this.router.navigate(['/preferences']);
      },
      error: (error) => {
        this.loading = false;
        this.error = error.error?.msg || 'Signup failed. Please try again.';
      }
    });
  }

  getFieldError(fieldName: string): string {
    const field = this.authForm.get(fieldName);
    if (field?.errors && field.touched) {
      if (field.errors['required']) return `${fieldName} is required`;
      if (field.errors['minlength']) return `${fieldName} must be at least ${field.errors['minlength'].requiredLength} characters`;
      if (field.errors['email']) return 'Please enter a valid email address';
    }
    return '';
  }
}
