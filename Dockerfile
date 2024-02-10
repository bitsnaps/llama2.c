# Use an official Debian image as a parent image
FROM debian:latest

# Set the working directory in the container to /app
WORKDIR /app

# Install git and wget for cloning the repo and downloading the model file
RUN apt-get update && \
    apt-get install -y git wget make gcc && \
    git lfs install

# Clone the Llama2 repository
RUN git clone --depth  1 https://github.com/bitsnaps/llama2.c.git .

# Compile and build the program
RUN make runfast

# Download the model file and place it in the models directory
RUN mkdir -p /app/models && \
    wget https://huggingface.co/karpathy/tinyllamas/resolve/main/stories110M.bin?download=true

# Copy the model file to the appropriate location (if needed)
COPY stories110M.bin /app/models/

# Expose port if the application runs a server
EXPOSE  8080

# Define environment variable
ENV MODEL_FILE=stories110M.bin

# The command to run the application
CMD ["./runfast", "-t", "0.9", "-p", "0.9", "-n", "1024", "-i", "Once upon a time, there "]
