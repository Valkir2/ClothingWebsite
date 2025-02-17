# # Use Python 3.11 as the base image
# FROM python:3.11

# # Set the working directory inside the container
# WORKDIR /app

# # Copy the project files into the container
# COPY . /app

# # Update package lists and install required dependencies
# RUN apt-get update && apt-get install -y netcat-openbsd \
#     && rm -rf /var/lib/apt/lists/*  # Clean up package lists to save space

# # Install Python dependencies
# RUN pip install --no-cache-dir -r requirements.txt

# # Wait for MySQL to be ready before running migrations
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# Use Python official image
FROM python:3.11

# Set the working directory
WORKDIR /app

# Copy project files
COPY . .

# Download and install wait-for-it.sh
RUN apt-get update && apt-get install -y curl
RUN curl -o /wait-for-it.sh https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8000
EXPOSE 8000

# Start command (Overridden by docker-compose)
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
