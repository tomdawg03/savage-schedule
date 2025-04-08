# Savage Schedule

A scheduling and project management system for Savage.

## Project Structure

```
savage-schedule/
├── frontend/           # Frontend Flask application
│   ├── app.py         # Frontend main application
│   ├── templates/     # HTML templates
│   └── static/        # Static files (CSS, JS, images)
├── backend/           # Backend Flask application
│   ├── app.py        # Backend main application
│   ├── routes/       # API routes
│   ├── models/       # Database models
│   └── services/     # Business logic services
└── requirements.txt   # Python dependencies
```

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd savage-schedule
   ```

2. Create and activate a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

4. Set up environment variables:
   - Copy `.env.example` to `.env` in both frontend and backend directories
   - Fill in the required environment variables

5. Initialize the database:
   ```bash
   cd backend
   python init_db.py
   ```

## Running the Application

1. Start the backend server:
   ```bash
   cd backend
   python app.py
   ```

2. Start the frontend server:
   ```bash
   cd frontend
   python app.py
   ```

## Deployment

1. Set up your EC2 instance with:
   - Python 3.8+
   - PostgreSQL
   - Nginx
   - Supervisor or systemd

2. Configure Nginx as a reverse proxy for both frontend and backend

3. Set up SSL certificates using Let's Encrypt

4. Configure environment variables on the server

5. Set up the database and run migrations

6. Start the application using Supervisor or systemd

## Environment Variables

### Backend (.env)
```
FLASK_APP=app.py
FLASK_ENV=production
SECRET_KEY=your-secret-key
DATABASE_URL=postgresql://user:password@localhost/savage
SENDGRID_API_KEY=your-sendgrid-key
TWILIO_ACCOUNT_SID=your-twilio-sid
TWILIO_AUTH_TOKEN=your-twilio-token
```

### Frontend (.env)
```
FLASK_APP=app.py
FLASK_ENV=production
BACKEND_URL=http://localhost:5001
```

## Contributing

1. Create a new branch for your feature
2. Make your changes
3. Submit a pull request

## License

This project is licensed under the MIT License. 