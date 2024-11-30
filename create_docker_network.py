import docker

def create_docker_network():
    client = docker.from_env()
    networks = client.networks.list(names=["surge"])
    if networks:
        print("The 'surge' network already exists.")
    else:
        print("Creating the 'surge' network without specific subnet or gateway...")
        client.networks.create("surge", driver="bridge")
        print("Custom bridged network 'surge' created successfully!")

if __name__ == "__main__":
    client = docker.from_env()
    if client:
        create_docker_network()
    else:
        print("Docker client initialization failed. Ensure Docker is running.")
