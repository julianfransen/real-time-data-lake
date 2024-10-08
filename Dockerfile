



# ------------------------------------------------------------------------------------------

# Step 1: Use an official Python runtime as a parent image
FROM python:3.11-slim

# Step 2: Set the working directories and environment variables
ENV AIRFLOW_HOME=/usr/local/real-time-data-lake/airflow
ENV ROOTDIR=/usr/local/real-time-data-lake

# Step 3: Set the working directory to the project root
WORKDIR ${ROOTDIR}

# Step 4: Install dependencies (including Airflow, Java, and Poetry)
# Install OpenJDK 17 (since OpenJDK 11 is not available), procps, and system dependencies
RUN apt-get update && apt-get install -y \
    procps \
    curl \
    nano \
    openjdk-17-jdk-headless \
    && apt-get clean

# Verify Java installation
RUN java --version

# Step 5: Install pip, Poetry, and Airflow
RUN pip install --upgrade pip \
    && pip install poetry \
    && pip install apache-airflow==2.10.2

# Step 6: Copy the Poetry configuration files into the container
COPY pyproject.toml poetry.lock ${ROOTDIR}/

# Step 7: Install project dependencies with Poetry
RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi

# Step 8: Copy the entire project into the container at the ROOTDIR
COPY . ${ROOTDIR}/

# Step 9: Ensure that necessary scripts are executable
RUN chmod +x ${ROOTDIR}/run.sh

# Step 11: Install any remaining dependencies using Poetry
RUN poetry install --no-interaction --no-ansi --no-root
EXPOSE 8080
CMD ["sh", "/usr/local/real-time-data-lake/run.sh"]