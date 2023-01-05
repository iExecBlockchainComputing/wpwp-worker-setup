# README #

This README document the required steps to deploy a worker and join the public Worker Pass Worker Pool

## What is this repository for? ##

* In this repository we show 3 ways of deploying your worker:
    * **Using vagrant** - this is a one-click deployment for less advanced users. If you don't know how to use command line and docker this is option for you
    * **Using docker-compose** - for more advanced users. This gives you more control over your worker and allows you to easier debug issues. To follow this steps you need to know how to use docker. We won't teach you basics. In this tutorial we assume you've already used docker and docker-compose
    * **Using cloud** provisioned VM like AWS EC2 or Azure VM - for users who want to deploy whe worker in a cloud. This tutorial is for really andvanced users who know how to provision computing resources and connect to them. We won't teach you how to do it - we assume you know. In this tutorial we provide you with a one click scripts to fast and easy configure your Virtual Machine and deploy a worker in a cloud
* Version: 1.0.0

---

## FAQ

### 1. When can I join the pool ###

The pool will accept only workers who hold WorkerPassWorkerPool NFT tokens in their wallets. 
This is only a utility NFT that gives the holder access to the pool. 
A worker without the token will be automatically removed from the pool.

### 2. How can I get the token? ###

You can participate in a token drop over this link - [workerpass.iex.ec](https://workerpass.iex.ec)
We will organize 3 drops and you'll have a chance to participate.
First people confirming, that they are willing to spin their workers and accept terms and conditions, will be granted the token.

### 3. How can I verify if I own the NFT ###

Visit: [https://blockscout-bellecour.iex.ec/address/your_wallet_address/tokens](https://blockscout-bellecour.iex.ec/) and verify if you hold the WPWP token   
![localImage](img/blockfolio.png)

### 4. How can I check my rewards? ###

Visit: [https://blockscout-bellecour.iex.ec/address/your_wallet_address/tokens](https://blockscout-bellecour.iex.ec/) and check the balance of your wallet.   
![blockfolio](img/blockfolio.png)

### 5. How do I monitor my worker ###

You can as well verify the number of tasks your worker executed using iExec Explorer
![explorer](img/explorer.png)

### 6. How can I verify if my worker correctly joined a workerpool? ###

Visit our [grafana](https://workerpool.iexecenterprise.com/) page and look for your wallet in an Active Worker List. If your worker is there it means it is properly connected.

### 7. What if my worker is not executing new tasks or is stuck ###

In that case, restart the worker and restart the machine. If that didn't help contact iex.ec support.

---

## Disclaimer

Unfortunately, you can't yet run a worker in ARM-based CPU - ( Worker runs only on 64-bit (x84) architecture)   
It implies that it is **not possible** to run the worker on e.g. MacBooks with M1/M2 ARM-based silicons or AWS EC2 t4g instances. 

---

## Who do I talk to? ##

* [Open a support ticket](https://iexecproject.atlassian.net/servicedesk/customer/portal/4/group/9/create/73)
