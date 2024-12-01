import docker

# Initialize Docker client
client = docker.from_env()

# Configuration
image_name = "jitesoft/python"
container_name = "jitesoft-python-container"
network_name = "surge"  # Custom bridge network

# Stop and remove existing container if it exists
try:
    container = client.containers.get(container_name)
    container.stop()
    container.remove()
    print("The container '%s' was stopped and removed successfully." % container_name)
except docker.errors.NotFound:
    print("No existing container named '%s' found." % container_name)

# Build the Docker image
print("Building Docker image '%s' using jitesoft/python..." % image_name)
client.images.build(path=".", tag=image_name)

# Run the container
print("Running Docker container '%s' on network '%s'..." % (container_name, network_name))
client.containers.run(
    image=image_name,
    name=container_name,
    network=network_name,  # Attach to the custom bridge network
    ports={"5000/tcp": 5000},  # Map port 5000
    detach=True
)

print("The container '%s' is running successfully on the '%s' network!" % (container_name, network_name))
