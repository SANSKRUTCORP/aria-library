#!/bin/bash
set -e

# Update system
apt-get update && apt-get upgrade -y

# Install Java 17 (OpenJDK)
apt-get install -y openjdk-17-jdk

# Install Maven and Ant
apt-get install -y maven ant

# Install Git
apt-get install -y git

# Create DSpace user
useradd -m dspace
mkdir -p /dspace
chown dspace:dspace /dspace

# Install Solr (Example: 9.4.0)
cd /opt
wget https://archive.apache.org/dist/solr/solr/9.4.0/solr-9.4.0.tgz
tar xzf solr-9.4.0.tgz
/opt/solr-9.4.0/bin/install_solr_service.sh solr-9.4.0.tgz

# Clone DSpace Backend (DSpace 8)
# Note: Using main branch or specific tag as needed
cd /home/dspace
git clone https://github.com/DSpace/DSpace.git
cd DSpace
git checkout dspace-8.0 # Adjust tag as needed

# Build DSpace
# Ensure database connection details are configured in local.cfg before build
# For this script, we'll assume we need to inject DB config or use environment variables
# This is a placeholder for the actual build command
mvn package -Dmirage2.on=true

# Install DSpace
cd dspace/target/dspace-installer
ant fresh_install

# Start DSpace (Standalone)
# java -jar /dspace/bin/dspace-server.jar
