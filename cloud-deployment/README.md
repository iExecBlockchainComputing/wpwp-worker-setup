# README #

This README documents the cloud deployment of the worker. We will not describe here how to spin an AWS EC2 instance or Azure VM.
In this readme, we focus on starting a worker on clean already provisioned machines.   
**Remember you NEED to have Worker Pass NFT on the worker's wallet before connecting to the pool**

### What is this repository for? ###

* **Quick summary**   
    This repository provides scripts that set up a clean VM and starts a worker
* **Version:** 1.0.0

### How do I get set up? ###

* **Summary of set up**
    1. You need to have provisioned VM - ubuntu or AWS-Linux
    2. Copy there the correct script in the desired location
    3. Run the script

* **Configuration**   
    Setup scripts take care of configuring the machine and starting the worker. You need to make sure you provide the required environment variables to the script.
* **Dependencies**   
    You don't need any dependencies installed apart from the clean Linux
* **How to run**    
    You can either run it with a .env file or by providing the required variables to the script in the command line

    * **Running with .env**  
    copy .env-defaults to .env file and fill it in with your private key to the wallet

        ```sh
        # REQUIRED VARIABLES:
        PRIVATE_KEY=0x123                             # Your private key to the wallet
        PROD_CORE_HOST=workerpool.iexecenterprise.com # This is the IP of the workerpool

        # Optional variables:
        WORKER_NAME=My_First_Worker_Name              # Set the name of your worker
        PROD_WALLET_PASSWORD=mySecretPassword         # Change this password to the one you've used for your wallet

        # Available CPU for a worker will be automatically set to available CPU on host machine -1
        # FORCE_WORKER_AVAILABLE_CPU=1                # uncomment only if you want to force an available CPU for the worker
        ```
        
        Paste the contents of the correct setup script to the file.   
        Give it execution rights `sudo chmod +x setup.sh`.    
        Run - `./setup.sh`

    * **Running with a command line**  
        Paste the contents of the correct setup script to the file. Give it an execution rights `sudo chmod +x setup.sh`  
        Run:  

        ```sh
        PRIVATE_KEY=0x1234... PROD_CORE_HOST=workerpool.iexecenterprise.com ./setup.sh
        ```
    
    * Stake 1 RLC - [Follow this instruction](https://github.com/iExecBlockchainComputing/wpwp-worker-setup#8-how-do-i-stake-my-rlc)

### Additional commands ###

* Check the logs of your worker

    ```sh
    docker-compose logs worker # to follow the new logs use -f flag $ docker-compose logs -f worker
    ```
    
### Who do I talk to? ###

* [Open a support ticket](https://iexecproject.atlassian.net/servicedesk/customer/portal/4/group/9/create/73)