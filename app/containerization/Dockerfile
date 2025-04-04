# Step 1: Use an official Python runtime as a parent image
FROM python:3.9-slim

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy the local directory contents into the container at /app
COPY ./app/python /app

# Step 4: Install dependencies
# We copy the requirements.txt file first to take advantage of Docker layer caching
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Expose the port the app will run on
EXPOSE 80

# Step 6: Install Gunicorn
RUN pip install gunicorn

# Step 7: Define the command to run the application with Gunicorn
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:80", "app:app"]
