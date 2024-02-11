FROM gitpod/workspace-full

# Install as root
#USER root

RUN apt-get update && \
    apt-get install -y git wget make gcc && \
    apt-get clean && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*;

# Compile & run as user
#USER gitpod

# Compile and build the program
RUN make runfast
RUN gcc api -o server

# The command to run the application
CMD ["./server"]
