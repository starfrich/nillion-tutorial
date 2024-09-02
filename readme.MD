# Nillion Verifier
Nillion recently launched their Verifier Program on August 27th! Early participants will be recognized for their contributions and gain a unique position within the Nillion community.

## How to be verifier?
In this repository, I will guide you through the process of running the verifier on an **Ubuntu VPS** with **root** access. If you are not using root, add `sudo` in the first command.

> **Warning:** This is not official documentation, and I do not recommend following this method as it might not be 100% accurate.


1. First, you need to install the [Keplr Wallet](https://www.keplr.app/get) on your browser. Do not create a wallet yet, as we will use a new wallet from the accuser credentials later.

<p>
2. Clone this repository for a quick installation:

```bash
git clone https://github.com/starfrich/nillion-tutorial.git && cd nillion-tutorial/ && chmod +x index.sh
```
```bash
./index.sh
```
</p>
<p>
3. You will see the output of your Nillion credentials like this:

![image](https://github.com/user-attachments/assets/51ef0ca8-c3de-4c2b-aa3c-ca768c726d3f)

Make sure to save the "Accuser Credentials" data in a safe place and ensure it is not visible to others.
</p>
<p>
4. Before proceeding, make sure no one is around you so they cannot see your accuser data! At this step, you will see your private key, which you need to import into the Keplr Wallet.

```bash
cat ~/nillion/accuser/credentials.json
```

The output will look like this:

![image](https://github.com/user-attachments/assets/bce6ff8f-4ee4-4ba5-800d-b4db041a47a7)
</p>
<p>
5. Add the Nillion RPC to your Keplr Wallet here: https://chains.keplr.app/ and search for "Nillion".

![image](https://github.com/user-attachments/assets/90f1befb-a640-4cdb-ac8b-e90e69a3d499)

Alternative RPC: 
```bash
https://nillion-testnet-rpc.polkachu.com
```
</p>
<p>
6. Fund your wallet using the faucet: https://faucet.testnet.nillion.com/
</p>
<p>
7. Open the verifier dashboard at: https://verifier.nillion.com/verifier, connect your wallet, and select "Verifier".

![image](https://github.com/user-attachments/assets/6c7f267d-f9ec-484f-937c-7f50addc0b61)

Then choose linux:

![image](https://github.com/user-attachments/assets/6e7bf611-39ce-4da4-a24f-063beab68d40)
</p>
<p>
8. After that, click "Open Step 5" to register your verifier address and public key.

![image](https://github.com/user-attachments/assets/4f69c0a2-8d0f-4b1b-a00a-3b78413d138e)

Then click "Complete Accuser Connection". You will see pop up to your keplr wallet, then click approve.
</p>
<p>
9. Now, proceed to Step 7 since we’ve already funded our wallet with the faucet. Go to: https://testnet.nillion.explorers.guru/account/(your_nillion_address) to check the first block your node registered in the transactions tab and look for type "Pay For".

![image](https://github.com/user-attachments/assets/e334d6ee-377f-49f1-a8e3-13bc116c3e94)

For example, my node registered at block 5245527, but we need to start our block 5 blocks before that, so I will start from block 5245522.

```bash
cd ~
```
```bash
docker run -d --name nillion -v ./nillion/accuser:/var/tmp nillion/retailtoken-accuser:v1.0.0 accuse --rpc-endpoint "https://testnet-nillion-rpc.lavenderfive.com" --block-start 5245522
```
![image](https://github.com/user-attachments/assets/216d8d02-e67f-40c7-b423-4b3775b829cf)
</p>

## CLI Commands:

<p>
Check logs:

```bash
docker logs -f nillion --tail 50
```
</p>
<p>
Verify if your verifier is registered: true and stores some secret:

```bash
docker logs --tail=1000000 nillion | grep -A 2 Registered | tail -3
```
</p>

## Known issue:
<p>
1. If the output from this command (docker logs --tail=1000000 nillion | grep -A 2 Registered | tail -3) is blank or empty: You might need to wait for 5-10 minutes.
</p>

<p>
2. Accuser not accusing:

```bash
docker restart nillion
```
</p>
<p>
3. RPC Error:

![image](https://github.com/user-attachments/assets/6f31f0eb-3bc3-4518-ac7c-162269db2523)

you can change your rpc to: 

```bash
https://nillion-testnet-rpc.polkachu.com
```

First, you need to stop and remove your existing container:
```bash
docker stop nillion && docker rm nillion
```
```bash
sudo docker run -d --name nillion -v $HOME/nillion/accuser:/var/tmp nillion/retailtoken-accuser:v1.0.0 accuse --rpc-endpoint "https://nillion-testnet-rpc.polkachu.com" --block-start (your_latest_block)
```
</p>

## Credit:
- [Nodes Guru](https://nodes.guru/testnets/nillion/setup-guide/en)
- [Polkachu](https://nillion-testnet-rpc.polkachu.com/)