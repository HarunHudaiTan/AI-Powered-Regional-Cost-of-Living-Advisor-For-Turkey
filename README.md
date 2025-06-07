# 🏠 AI-Powered Regional Cost of Living Advisor For Turkey

An intelligent web application that provides personalized cost of living analysis and recommendations for different regions in Turkey using AI technology.

## 🌟 Features

### Core Functionality
- **Personalized Analysis**: AI-powered cost of living comparisons between Turkish cities and districts
- **User Authentication**: Secure JWT-based login and registration system
- **Comprehensive Preferences**: Detailed user preference management including housing, transportation, education, and lifestyle factors
- **Real-time Data**: Integration with current market prices for utilities, fuel, education, and housing
- **PDF Reports**: Generate, preview, and download detailed analysis reports in PDF format

### Key Components
- **Housing Analysis**: Rent prices, utility costs (electricity, gas, water, internet)
- **Transportation**: Public transport costs, fuel prices for vehicle owners
- **Education**: University tuition fees and related educational expenses
- **Lifestyle**: Entertainment, gym, healthcare, clothing, and subscription costs
- **Market Prices**: Grocery and daily necessities cost comparison

## 🏗️ Architecture

### Backend (Flask + MySQL)
- **Framework**: Flask with Flask-JWT-Extended for authentication
- **Database**: MySQL 8.0 with SQLAlchemy ORM
- **AI Integration**: Custom LLM classes for intelligent analysis
- **APIs**: RESTful API endpoints for user management and data processing

### Frontend (Angular 18)
- **Framework**: Angular 18 with Server-Side Rendering (SSR)
- **UI/UX**: Modern, responsive design
- **PDF Generation**: jsPDF and html2canvas for report generation
- **Markdown Support**: Marked library for content formatting

## 🚀 Getting Started

### Prerequisites
- **Backend**: Python 3.8+, MySQL 8.0
- **Frontend**: Node.js 18+, Angular CLI
- **Docker**: Docker and Docker Compose (recommended)

### Installation

#### Option 1: Using Docker (Recommended)

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/AI-Powered-Regional-Cost-of-Living-Advisor-For-Turkey.git
   cd AI-Powered-Regional-Cost-of-Living-Advisor-For-Turkey
   ```

2. **Start MySQL database**
   ```bash
   cd cost-of-living-advisor-backend
   docker-compose up -d
   ```

3. **Set up the backend**
   ```bash
   # Install Python dependencies
   pip install -r requirements.txt  # You may need to create this file
   
   # Run the Flask application
   python api.py
   ```

4. **Set up the frontend**
   ```bash
   cd ../cost-of-living-advisor-front-end
   
   # Install dependencies
   npm install
   
   # Start the development server
   npm start
   ```

#### Option 2: Manual Setup

1. **Database Setup**
   - Install MySQL 8.0
   - Create database: `user_details_and_preferences`
   - Update connection details in `api.py` if needed

2. **Backend Setup**
   ```bash
   cd cost-of-living-advisor-backend
   
   # Install required packages
   pip install flask flask-jwt-extended flask-cors flask-sqlalchemy mysql-connector-python werkzeug
   
   # Run the application
   python api.py
   ```

3. **Frontend Setup**
   ```bash
   cd cost-of-living-advisor-front-end
   npm install
   npm start
   ```

### Environment Configuration

Create a `.env` file in the backend directory with:
```env
SECRET_KEY=your-secret-key-here
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=rootpassword
DB_NAME=user_details_and_preferences
JWT_ACCESS_TOKEN_EXPIRES=24
```

## 📚 API Documentation

### Authentication Endpoints
- `POST /api/signup` - User registration
- `POST /api/login` - User authentication
- `GET /api/profile` - Get user profile (requires JWT)

### Preferences Management
- `POST /api/preferences` - Create user preferences
- `GET /api/preferences` - Retrieve user preferences
- `PUT /api/preferences` - Update user preferences
- `DELETE /api/preferences` - Delete user preferences

### Analysis
- `GET /api/generate_root_llm_response` - Generate AI-powered cost of living analysis

## 🎯 Usage Guide

### 1. User Registration & Login
- Create an account with username, email, and password
- Login to receive JWT token for authenticated requests

### 2. Set Preferences
Configure your profile with:
- **Location**: Current and target city/district
- **Personal Info**: Age, family size, monthly income
- **Housing**: Current rent, utility bills, preferred housing type
- **Transportation**: Public transport usage, vehicle ownership
- **Education**: University preferences (if applicable)
- **Lifestyle**: Entertainment, gym, healthcare budgets

### 3. Generate Analysis
- Navigate to the analysis section
- AI processes your preferences against regional data
- Receive personalized recommendations and cost comparisons

### 4. Export Reports
- Preview analysis in formatted HTML
- Generate PDF reports for offline viewing
- Download detailed cost breakdown reports

## 🤖 AI Components

### LLM Integration
The system uses custom AI classes for intelligent analysis:

- **`Root.py`**: Main LLM orchestrator for generating comprehensive analysis
- **`UserPreferencesManager.py`**: Manages user data and preferences for AI processing
- **`proj_llm_agent.py`**: Specialized AI agent for regional cost analysis
- **`calculations.py`**: Utility functions for cost calculations

### Data Sources
- Real estate prices by region
- Utility cost databases
- University tuition information
- Market and grocery prices
- Fuel and transportation costs

## 🛠️ Development

### Project Structure
```
AI-Powered-Regional-Cost-of-Living-Advisor-For-Turkey/
├── cost-of-living-advisor-backend/
│   ├── api.py                          # Main Flask application
│   ├── main.py                         # Entry point
│   ├── docker-compose.yml              # Database setup
│   ├── database_export.sql             # Database schema
│   └── classes_for_llm/               # AI components
│       ├── Root.py                     # Main LLM class
│       ├── UserPreferencesManager.py   # User data management
│       ├── proj_llm_agent.py          # Analysis agent
│       ├── calculations.py            # Utility calculations
│       └── [price_data_directories]/  # Regional data
└── cost-of-living-advisor-front-end/
    ├── src/app/
    │   ├── components/                 # Angular components
    │   │   ├── auth-form/             # Authentication
    │   │   ├── preferences/           # User preferences
    │   │   ├── dashboard/             # Main dashboard
    │   │   └── analysis/              # Analysis & PDF
    │   └── services/                  # Angular services
    ├── package.json                   # Dependencies
    └── angular.json                   # Angular configuration
```

### Running Tests
```bash
# Frontend tests
cd cost-of-living-advisor-front-end
npm test

# Backend tests (if implemented)
cd cost-of-living-advisor-backend
python -m pytest
```

### Building for Production
```bash
# Frontend production build
cd cost-of-living-advisor-front-end
npm run build

# Backend production setup
cd cost-of-living-advisor-backend
# Configure production database and environment variables
```

## 🔧 Configuration

### Database Schema
The application uses MySQL with the following main tables:
- `users`: User authentication data
- `user_preferences`: Comprehensive user preference storage

### Frontend Proxy Configuration
The Angular app uses a proxy configuration (`proxy.conf.json`) to communicate with the Flask backend during development.

## 🚨 Troubleshooting

### Common Issues
1. **Database Connection**: Ensure MySQL is running and credentials are correct
2. **CORS Errors**: Backend includes CORS configuration for `localhost:4200`
3. **JWT Errors**: Check token expiration and authorization headers
4. **PDF Generation**: Ensure browser supports required APIs

### Debug Mode
Enable debug mode in Flask:
```python
app.run(debug=True)
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support and questions:
- Create an issue in the GitHub repository
- Contact the development team

## 🔮 Future Enhancements

- Mobile application development
- Real-time price updates via web scraping
- Integration with more Turkish cities
- Multi-language support
- Enhanced AI models for better predictions
- Social features for community recommendations

---

Built with ❤️ for helping people make informed decisions about living in Turkey. 