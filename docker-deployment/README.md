# README #

Run iExec Worker

* **Quick summary**   
This README documents the steps to set up a worker and join a workerpool using docker-compose
* **Version** - 1.0.0

---

## How do I get set up? ##

Please confirm you have installed all dependencies mentioned in the Prerequisites step.   
Remember your worker needs to have WorkerPassWorkerPool NFT on your wallet to join Worker Pass Worker Pool.   

To confirm you have that NFT visit:   
[https://blockscout-bellecour.iex.ec/address/YourWalletaddress/tokens](https://blockscout-bellecour.iex.ec/address/0x587dcc67c6AB1ea86E4AA043a1282d584B05BFCc/tokens)

**Install:**

    * Docker we use: version 20.10.17, build 100c701
    * Docker Compose - we use: docker-compose version 1.29.2, build 5becea4c
    * NVM - we use: 0.39.1
    * node - we use: v16.18.1 | npm@8.19.2
    * git - we use: 2.37.1
    * iExec CLI - we use: 7.2.2

### Prerequisites Linux ###

* Install the following tools on your machine - pick the correct script - ubuntu or aws linux. If you use some other Linux distribution you'll need to modify the scripts yourself 

    ```sh
    sudo chmod +x setup-ubuntu.sh 
    ./ setup-ubuntu.sh
    ```

* Verify the number of CPUs on your machine. You'll later assign to your worker the number of CPUs from your machine:

    ```sh
    $ echo "Threads/core: $(nproc --all)"

    CPU threads: 4
    ```
    
    In this machine, there are 4 cores

### Prerequisites Windows ###

* Install the following tools on your machine:
    * [Docker](https://docs.docker.com/desktop/install/windows-install/) with docker-compose
    * Install Node at least v16 - we recommend using [nvm](https://github.com/coreybutler/nvm-windows#readme)
    * install [iExec CLI](https://github.com/iExecBlockchainComputing/iexec-sdk#cli) - `npm install -g iexec`
* Verify the number of CPUs on your machine using CMD:  

    ```sh
    $ wmic cpu get NumberOfCores,NumberOfLogicalProcessors
    NumberOfCores  NumberOfLogicalProcessors
    6              12
    ```

    In this machine, we have 6 cors

    Or follow the instructions from this [link](https://www.top-password.com/blog/find-number-of-cores-in-your-cpu-on-windows-10/)

### Prerequisites MacOs ###

* Install the following tools on your machine:
    * [Homebrew](https://brew.sh/) - MacOs Package manager

        ```sh
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ```
    * [Docker](https://docs.docker.com/desktop/install/windows-install/) with docker-compose

        ```sh
        brew install docker
        brew install docker-compose
        ```

    * Install Node at least v16 - we recommend using [nvm](https://github.com/coreybutler/nvm-windows#readme)

        ```sh
        brew install nvm
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

        # Install node v16
        nvm install v16
        nvm use v16
        ```

    * install [iExec CLI](https://github.com/iExecBlockchainComputing/iexec-sdk#cli) - `npm install -g iexec`
* Verify the number of CPUs on your machine using CMD:  

    ```sh
    $ sysctl hw.physicalcpu
    hw.physicalcpu: 16
    ```

    In this machine, we have 16 cors

### Configure Project ###

Execute the following command to provision your iExec-Worker VM

1. First clone this repository -   
`gh repo clone iExecBlockchainComputing/wpwp-worker-setup`
2. Change the directory to docker-deployment   
`cd ./wpwp-worker-setup/docker-deployment`
3. Create iexec wallet
    * Import your Ethereum wallet using your private key into the wallet file (Remember about the dot at the end!):  

        ```sh
        # Create Wallet
        iexec wallet import <private_key> --password mySecretPassword --keystoredir .

        # Rename wallet
        mv UTC--* worker_wallet.json # Rename the wallet file
        ```

    * Create a new wallet (remember about the dot at the end!):

        ```sh
        $ iexec wallet create --password mySecretPassword --keystoredir .
                                                                                                    
            ⚠ Option --password may be unsafe, make sure to know what you do
            ✔ Your wallet address is 0x587dcc67c6AB1ea86E4AA043a1282d584B05BFCc
            Wallet saved in "UTC--2022-11-16T14-25-59.933000000Z--587dcc67c6AB1ea86E4AA043a1282d584B05BFCc":

            address: 587dcc67c6AB1ea86E4AA043a1282d584B05BFCc
            id:      686ce8ff-d8f6-44f0-9413-eaf174d0e799
            version: 3
            crypto: 
            cipher:       aes-128-ctr
            cipherparams: 
                iv: 6f7d3d2422266804ef2f7934f5238a39
            ciphertext:   229bb48210f18216b0fbd6f22f29cf7d33d5c6b330a725632fa99fe76074b649
            kdf:          scrypt
            kdfparams: 
                salt:  e0ef3cb212da7821223cec196ae26679f9e00195ead456c2bce072305ec087f0
                n:     131072
                dklen: 32
                p:     1
                r:     8
            mac:          38262220e0dc84218b2f8b9c1ec9d0c92999e51bd16bd16160aafd8bd2e121de

            ⚠ You must backup your wallet file in a safe place!

        $ mv UTC--* worker_wallet.json # Rename the wallet file
        ```
4. Copy contents of .env-defaults to .env and configure the following variables in the .env file:
    Remember to correctly set the number of available CPUs.

    ```sh
    WORKER_AVAILABLE_CPU=2 # This is the number of available CPUs in your machine -1
    WORKER_NAME=My_First_Worker_Name # This is the name of your worker
    PROD_WALLET_PASSWORD=mySecretPassword # Change this password to the one you've used for your wallet

    # Optionally you can modify that if the worker doesn't want to start
    RESULTS_DIR=/tmp/results # change this to the path you have access to
    ```
5. Stake 1 RLC - [Follow this instruction](https://github.com/iExecBlockchainComputing/wpwp-worker-setup#8-how-do-i-stake-my-rlc)

### Start your worker ###

Start your worker using docker-compose

```sh
docker-compose up -d
```

### Additional commands ###

* Check the logs of your worker

    ```sh
    docker-compose logs worker # to follow the new logs use -f flag $ docker-compose logs -f worker
    ```

* Check your worker's private key:

    ```sh
    $ iexec wallet show --show-private-key --keystoredir . --wallet-file worker_wallet.json --password mySecretPassword
        ℹ Wallet file:
        privateKey: 0x7558ceabb955309e3725667974c81831531dddcc49ebafc1d6124f2a573b214d
        publicKey:  0x04a5302a43ff3acac78c16af2f584f2c197f076d81469ccfe95f52ffb061f31855a53e610675dcec94e25a42e5d3c45297fe8040347ab00b156bc03bcd4772f131
        address:    0x587dcc67c6AB1ea86E4AA043a1282d584B05BFCc
    ```

---

## Who do I talk to? ##

* [Open a support ticket](https://iexecproject.atlassian.net/servicedesk/customer/portal/4/group/9/create/73)
