import docker

# Initialize Docker client
client = docker.from_env()

# Configuration
image_name = "jitesoft/python"
container_name = "jitesoft-python-container"
network_name = "surge"  # Custom bridge network
app_command = "python /app/app.py"  # Command to run the Python application

# Stop and remove existing container if it exists
try:
    container = client.containers.get(container_name)
    container.stop()
    container.remove()
    print("The container '%s' was stopped and removed successfully." % container_name)
except docker.errors.NotFound:
    print("No existing container named '%s' found." % container_name)

# Pull the base image (jitesoft/python)
print("Pulling Docker image '%s' from Docker Hub..." % image_name)
client.images.pull(image_name)

# Run the container with the command to execute app.py
print("Running Docker container '%s' on network '%s' with command '%s'..." % (container_name, network_name, app_command))
client.containers.run(
    image=image_name,
    name=container_name,
    network=network_name,  # Attach to the custom bridge network
    ports={"5000/tcp": 5000},  # Map port 5000
    detach=True,
    command=app_command  # Run the app.py script inside the container
)

print("The container '%s' is running successfully on the '%s' network!" % (container_name, network_name))
