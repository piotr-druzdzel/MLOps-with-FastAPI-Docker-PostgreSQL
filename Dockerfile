FROM python:3.8-slim

WORKDIR /app

# Install PostgreSQL client for database initialization
RUN apt-get update && apt-get install -y postgresql-client

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Custom script to wait for PostgreSQL to be ready before starting the application
COPY init-db.sh /app/init-db.sh
RUN chmod +x /app/init-db.sh

CMD ["./init-db.sh"]
