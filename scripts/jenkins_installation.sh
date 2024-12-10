#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Prompt user for Jenkins version
read -p "Enter the Jenkins version you want to install (or press Enter for the latest stable version): " JENKINS_VERSION
JENKINS_VERSION=${JENKINS_VERSION:-latest}

# Function to install Jenkins on Debian-based systems
install_jenkins_debian() {
    echo "Installing Jenkins $JENKINS_VERSION on Debian-based system..."
    sudo apt update
    sudo apt install -y openjdk-11-jdk wget gnupg
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
    sudo apt update
    if [ "$JENKINS_VERSION" == "latest" ]; then
        sudo apt install -y jenkins
    else
        sudo apt install -y jenkins="$JENKINS_VERSION"
    fi
    echo "Jenkins $JENKINS_VERSION installed successfully."
}

# Function to install Jenkins on Red Hat-based systems
install_jenkins_rhel() {
    echo "Installing Jenkins $JENKINS_VERSION on Red Hat-based system..."
    sudo yum install -y java-11-openjdk wget
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    if [ "$JENKINS_VERSION" == "latest" ]; then
        sudo yum install -y jenkins
    else
        sudo yum install -y jenkins-"$JENKINS_VERSION"
    fi
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    echo "Jenkins $JENKINS_VERSION installed successfully."
}

# Function to install Jenkins on macOS
install_jenkins_mac() {
    echo "Installing Jenkins $JENKINS_VERSION on macOS..."
    if ! command_exists brew; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    if [ "$JENKINS_VERSION" == "latest" ]; then
        brew install jenkins-lts
    else
        echo "Installing specific versions is not supported via Homebrew. Installing the latest version instead."
        brew install jenkins-lts
    fi
    echo "Jenkins installed successfully."
}

# Function to guide Windows users
install_jenkins_windows() {
    echo "Detected Windows operating system."
    echo "Please follow these steps to install Jenkins $JENKINS_VERSION:"
    echo "1. Visit the official Jenkins download page: https://www.jenkins.io/download/"
    if [ "$JENKINS_VERSION" == "latest" ]; then
        echo "2. Download the latest Windows installer."
    else
        echo "2. Locate the desired version ($JENKINS_VERSION) under the 'Older Versions' section."
    fi
    echo "3. Install Java if not already installed: https://www.oracle.com/java/technologies/javase-jdk11-downloads.html"
    echo "4. Run the Jenkins installer and follow the setup instructions."
    echo "5. Jenkins will be available as a Windows service and accessible at http://localhost:8080 after installation."
}

# Main script logic
echo "Detecting operating system..."
if [ -f /etc/debian_version ]; then
    install_jenkins_debian
elif [ -f /etc/redhat-release ]; then
    install_jenkins_rhel
elif [[ "$OSTYPE" == "darwin"* ]]; then
    install_jenkins_mac
elif [[ "$OS" == "Windows_NT" ]]; then
    install_jenkins_windows
else
    echo "Unsupported operating system. Please install Jenkins manually."
    exit 1
fi

echo "Installation complete. Start Jenkins by running the appropriate service start command for your OS."

