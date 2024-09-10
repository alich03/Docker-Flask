
# Integration of Docker Container with Datadog
### Testing Method
✅[Install the Docker Compose](https://docs.docker.com/compose/install/)\
✅Clone my respository\
✅Update your `DD_API_KEY`and `DD_SITE` in `docker-compose.yml`\
✅Run all containers with `docker-compose up`



### Docker Compose, Dockerfile and Testing Script

A simple `docker-compose.yml` file is shown as:

```yaml
version: "3"  # Define the version of the Docker Compose file format

services:
  # Datadog agent service configuration
  datadog-agent:
    image: datadog/agent:latest                    # Use the latest Datadog agent image
    container_name: datadog-agent                  # Set a custom name for the container
    environment:                                   # Environment variables for the Datadog agent
      - DD_API_KEY=<YOUR API KEY>                  # Replace with your actual Datadog API key
      - DD_SITE=<YOUR SITE>                        # Datadog site to send data to (e.g., US, EU)
      - DD_LOGS_ENABLED=true                       # Enable log collection in the Datadog agent
      - DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true  # Collect logs from all containers
      - DD_APM_ENABLED=true                   # Enable APM (Application Performance Monitoring)
      - DD_PROCESS_AGENT_ENABLED=true              # Enable the process agent for monitoring
    volumes:                           # Mount system directories for Docker and host monitoring
      - /var/run/docker.sock:/var/run/docker.sock:ro  # Read-only access to Docker socket for container monitoring
      - /proc/:/host/proc/:ro                      # Read-only access to host's proc directory
      - /sys/fs/cgroup/:/host/sys/fs/cgroup:ro     # Read-only access to host's cgroup directory
    platform: linux/amd64  # Set the platform to linux/amd64 for compatibility

  # Python application service configuration
  python-app:
    build:                                      # Build configuration for the Python app service
      context: .                                # Set the build context to the current directory
      dockerfile: Dockerfile              # Specify the Dockerfile to use for building the image
    depends_on:                                 # Specify dependencies for this service
      - datadog-agent                 # Ensure that the Datadog agent starts before this service
    environment:                                # Environment variables for the Python app
      - DD_AGENT_HOST=datadog-agent    # Set the Datadog agent host for the app to send metrics to
      - DD_SITE=<YOUR SITE> # Replace with your actual Datadog site (e.g., datadoghq.com, datadoghq.eu)
    platform: linux/amd64  # Set the platform to linux/amd64 for compatibility

```

A simple `Dockerfile` file is shown as:
```yaml
FROM ubuntu:20.04



RUN apt update && apt install software-properties-common -y
RUN apt install python3 -y && apt install python3-pip -y 

RUN pip install numpy pandas matplotlib seaborn flask

RUN pip install flask_cors

WORKDIR test_app

COPY . .

ENV FLASK_RUN_HOST=0.0.0.0

RUN apt install software-properties-common 

EXPOSE 5000

# CMD ["python3","app.py"]


# WORKDIR

# ENV 

# COPY

# ADD
```

A simple `testing_script.py` is shown as:

```py
import time
import logging

# Configure logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


def main():
    while True:
        logger.info('This is an info message')
        time.sleep(5)


if __name__ == "__main__":
    main()
    
```
