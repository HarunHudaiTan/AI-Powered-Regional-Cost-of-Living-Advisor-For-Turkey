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
  isEditMode = false;

  // Options for dropdowns
  housingTypes = ['Apartment', 'House', 'Studio', 'Shared Room'];
  roomNumbers = ['1', '1+1', '2+1', '3+1', '4+1', '5+'];
  vehicleTypes = ['Car', 'Motorcycle', 'Bicycle'];
  fuelCapacities = ['30-40L', '40-50L', '50-60L', '60L+'];
  fuelTypes = ['Gasoline', 'Diesel', 'LPG', 'Electric', 'Hybrid'];
  distributorPreferences = ['Shell', 'BP', 'Petrol Ofisi', 'Opet', 'Total', 'No Preference'];

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
      } else {
        // Try to load existing preferences
        this.loadExistingPreferences();
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
        fuel_tank_monthly_fill_count: [0],
        distributor_preference: [''],
        vehicle_fuel_type: ['']
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
      // quantity_per_month: [1, [Validators.required, Validators.min(1)]], // Commented out - may use later
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

  loadExistingPreferences(): void {
    this.authService.getPreferences().subscribe({
      next: (response) => {
        if (response && response.user_profile) {
          this.isEditMode = true;
          this.populateForm(response.user_profile);
        }
      },
      error: (error) => {
        // If no preferences found (404), that's ok - user will create new ones
        if (error.status !== 404) {
          console.error('Error loading preferences:', error);
        }
      }
    });
  }

  populateForm(userProfile: any): void {
    // Populate the form with existing data
    this.preferencesForm.patchValue(userProfile);
    
    // Handle grocery list separately since it's a FormArray
    if (userProfile.shopping_preferences?.grocery_list) {
      const groceryArray = this.preferencesForm.get('shopping_preferences.grocery_list') as FormArray;
      groceryArray.clear();
      
      userProfile.shopping_preferences.grocery_list.forEach((item: any) => {
        const groceryItem = this.fb.group({
          item_name: [item.item_name || '', Validators.required],
          // quantity_per_month: [item.quantity_per_month || 1, [Validators.required, Validators.min(1)]], // Commented out - may use later
          preferred_brand: [item.preferred_brand || '']
        });
        groceryArray.push(groceryItem);
      });
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

    const saveOperation = this.isEditMode 
      ? this.authService.updatePreferences(formData)
      : this.authService.createPreferences(formData);

    saveOperation.subscribe({
      next: (response) => {
        this.loading = false;
        this.success = this.isEditMode 
          ? 'Preferences updated successfully!' 
          : 'Preferences saved successfully!';
        setTimeout(() => {
          // Navigate to dashboard or main app
          this.router.navigate(['/dashboard']);
        }, 2000);
      },
      error: (error) => {
        this.loading = false;
        this.error = error.error?.msg || `Failed to ${this.isEditMode ? 'update' : 'save'} preferences. Please try again.`;
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
