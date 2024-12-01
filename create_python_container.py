import docker

# Initialize Docker client
client = docker.from_env()

# Configuration
image_name = "jitesoft/python"
container_name = "jitesoft-python-container"
network_name = "surge"  # Custom bridge network
# Modified command to start the Python interactive shell
app_command = "python3"

# Check if the container exists
containers = client.containers.list(all=True, filters={"name": container_name})
if containers:
    print("Stopping and removing existing container '%s'..." % container_name)
    container = containers[0]
    container.stop()
    container.remove()
    print("The container '%s' was stopped and removed successfully." % container_name)
else:
    print("No existing container named '%s' found." % container_name)

# Pull the base image (jitesoft/python)
print("Pulling Docker image '%s' from Docker Hub..." % image_name)
client.images.pull(image_name)

# Run the container with the Python 3 interactive shell
print("Running Docker container '%s' on network '%s' with command '%s'..." % (container_name, network_name, app_command))
container = client.containers.run(
    image=image_name,
    name=container_name,
    network=network_name,  # Attach to the custom bridge network
    ports={"5000/tcp": 5000},  # Map port 5000
    detach=True,
    command=app_command  # Start Python interactive shell
)

print("The container '%s' is running successfully on the '%s' network!" % (container_name, network_name))

# Execute Python commands inside the running container
print("Executing Python commands inside the Python shell in the container...")
exec_result = container.exec_run("python3 -c \"print('Welcome to Python Shell')\"")
print("Command output: %s" % exec_result.output.decode())

exec_result = container.exec_run("python3 -c \"import platform; print('Python Version:', platform.python_version())\"")
print("Command output: %s" % exec_result.output.decode())

exec_result = container.exec_run("python3 -c \"x = 5 + 10; print('Calculation Result:', x)\"")
print("Command output: %s" % exec_result.output.decode())
