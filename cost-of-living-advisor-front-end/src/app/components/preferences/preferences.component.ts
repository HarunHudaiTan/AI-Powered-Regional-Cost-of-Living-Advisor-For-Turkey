import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormArray } from '@angular/forms';
import { Router } from '@angular/router';
import { AuthService } from '../../services/auth.service';

@Component({
  selector: 'app-preferences',
  templateUrl: './preferences.component.html',
  styleUrls: ['./preferences.component.css']
})
export class PreferencesComponent implements OnInit {
  preferencesForm: FormGroup;
  loading = false;
  error = '';
  success = '';
  currentStep = 1;
  totalSteps = 6;

  // Options for dropdowns
  housingTypes = ['Apartment', 'House', 'Studio', 'Shared Room'];
  roomNumbers = ['1', '1+1', '2+1', '3+1', '4+1', '5+'];
  vehicleTypes = ['Car', 'Motorcycle', 'Bicycle'];
  fuelCapacities = ['30-40L', '40-50L', '50-60L', '60L+'];

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router
  ) {
    this.preferencesForm = this.createForm();
  }

  ngOnInit(): void {
    // Check if user is authenticated
    this.authService.isAuthenticated().subscribe(isAuth => {
      if (!isAuth) {
        this.router.navigate(['/auth']);
      }
    });
  }

  createForm(): FormGroup {
    return this.fb.group({
      // Step 1: Location Information
      current_location: this.fb.group({
        city: ['', Validators.required],
        district: ['', Validators.required]
      }),
      target_location: this.fb.group({
        city: ['', Validators.required],
        district: ['', Validators.required]
      }),

      // Step 2: Personal Details
      personal_details: this.fb.group({
        age: ['', [Validators.required, Validators.min(18), Validators.max(100)]],
        family_size: ['', [Validators.required, Validators.min(1)]],
        monthly_net_income: ['', [Validators.required, Validators.min(0)]]
      }),

      // Step 3: Current Expenses - Housing
      current_expenses: this.fb.group({
        housing: this.fb.group({
          monthly_rent: ['', [Validators.required, Validators.min(0)]],
          electricity_bill: ['', [Validators.required, Validators.min(0)]],
          natural_gas_bill: ['', [Validators.required, Validators.min(0)]],
          water_bill: ['', [Validators.required, Validators.min(0)]],
          internet_bill: ['', [Validators.required, Validators.min(0)]]
        }),

        // Step 4: Transportation & Education
        transportation: this.fb.group({
          uses_public_transportation: [false],
          is_the_user_student: [false],
          public_transport_monthly_pass: [0],
          monthly_fuel_cost: [0],
          parking_fees: [0]
        }),
        education: this.fb.group({
          wants_education_analysis: [false],
          target_university: [''],
          current_tuition_semester: [0]
        }),

        // Step 5: Other Expenses
        other_expenses: this.fb.group({
          gym_membership: [0],
          entertainment_monthly: [0],
          clothing_monthly: [0],
          healthcare_monthly: [0],
          subscriptions_monthly: [0],
          travel_vacation_monthly: [0]
        })
      }),

      // Step 6: Preferences
      housing_preferences: this.fb.group({
        preferred_housing_type: ['', Validators.required],
        number_of_rooms: ['', Validators.required]
      }),
      vehicle_ownership: this.fb.group({
        owns_vehicle: [false],
        vehicle_type: [''],
        fuel_tank_capacity: [''],
        fuel_tank_monthly_fill_count: [0]
      }),
      shopping_preferences: this.fb.group({
        grocery_list: this.fb.array([])
      })
    });
  }

  get groceryList(): FormArray {
    return this.preferencesForm.get('shopping_preferences.grocery_list') as FormArray;
  }

  addGroceryItem(): void {
    const item = this.fb.group({
      item_name: ['', Validators.required],
      quantity_per_month: [1, [Validators.required, Validators.min(1)]],
      preferred_brand: ['']
    });
    this.groceryList.push(item);
  }

  removeGroceryItem(index: number): void {
    this.groceryList.removeAt(index);
  }

  nextStep(): void {
    if (this.isCurrentStepValid()) {
      this.currentStep++;
    }
  }

  prevStep(): void {
    this.currentStep--;
  }

  isCurrentStepValid(): boolean {
    switch (this.currentStep) {
      case 1:
        return this.preferencesForm.get('current_location')?.valid! && 
               this.preferencesForm.get('target_location')?.valid!;
      case 2:
        return this.preferencesForm.get('personal_details')?.valid!;
      case 3:
        return this.preferencesForm.get('current_expenses.housing')?.valid!;
      case 4:
        return this.preferencesForm.get('current_expenses.transportation')?.valid! &&
               this.preferencesForm.get('current_expenses.education')?.valid!;
      case 5:
        return this.preferencesForm.get('current_expenses.other_expenses')?.valid!;
      case 6:
        return this.preferencesForm.get('housing_preferences')?.valid! &&
               this.preferencesForm.get('vehicle_ownership')?.valid!;
      default:
        return true;
    }
  }

  onSubmit(): void {
    if (this.preferencesForm.invalid) {
      this.error = 'Please fill in all required fields correctly.';
      return;
    }

    this.loading = true;
    this.error = '';

    const formData = {
      user_profile: this.preferencesForm.value
    };

    this.authService.createPreferences(formData).subscribe({
      next: (response) => {
        this.loading = false;
        this.success = 'Preferences saved successfully!';
        setTimeout(() => {
          // Navigate to dashboard or main app
          this.router.navigate(['/dashboard']);
        }, 2000);
      },
      error: (error) => {
        this.loading = false;
        this.error = error.error?.msg || 'Failed to save preferences. Please try again.';
      }
    });
  }

  getStepTitle(): string {
    switch (this.currentStep) {
      case 1: return 'Location Information';
      case 2: return 'Personal Details';
      case 3: return 'Housing Expenses';
      case 4: return 'Transportation & Education';
      case 5: return 'Other Expenses';
      case 6: return 'Preferences & Final Setup';
      default: return 'Preferences';
    }
  }

  getFieldError(fieldPath: string): string {
    const field = this.preferencesForm.get(fieldPath);
    if (field?.errors && field.touched) {
      if (field.errors['required']) return 'This field is required';
      if (field.errors['min']) return `Minimum value is ${field.errors['min'].min}`;
      if (field.errors['max']) return `Maximum value is ${field.errors['max'].max}`;
    }
    return '';
  }
}
