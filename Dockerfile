FROM python:3.8-slim

WORKDIR /app

# Install PostgreSQL client for database initialization
RUN apt-get update && apt-get install -y postgresql-client

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Copy initialization script
COPY init-db.sh /app/init-db.sh
RUN chmod +x /app/init-db.sh

# Startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["./start.sh"]
