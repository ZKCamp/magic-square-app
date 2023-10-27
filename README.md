# Magic Square App

## Setup

* First, we need to install the correct working versions of Aleo and SnarkOS

* Download the binary of snarkos from [here](https://github.com/AleoHQ/snarkOS/releases/tag/v2.2.1) based on your operating system. Place the binary in global path for it to be accessible globally. An example command of how to add it to path is given below:

```sh
mv snarkos /Users/shubham/.cargo/bin/snarkos
```

* Download the binary of leo from [here](https://github.com/AleoHQ/leo/releases/tag/v1.10.0). Place the leo binary in the path too, similar to how it is done above.

* Install `tmux`. For MacOS you can use the command below

```
brew install tmux
```

* Download the devnet script from [here](https://github.com/AleoHQ/snarkOS/blob/testnet3/devnet.sh) and run it to start the development network.

* Once you have started the network, transfer some credits to your developer account public balance. Replace the `DESTINATION_ADDRESS`.

```sh
snarkos developer execute credits.aleo transfer_private_to_public  "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 1000000000000u64.private,  _nonce: 2375769092384433893584628345181087640612139758569367275399070851734157235845group.public}" "DESTINATION_ADDRESS" 837500000000u64 --private-key "APrivateKey1zkp8CZNn3yeCseEtxuVPbDCwSyhGW6yZKUYKfgXmcpoGPWH" --query "http://localhost:3030" --broadcast "http://localhost:3030/testnet3/transaction/broadcast" --priority-fee 10000000000 --record "{  owner: aleo1rhgdu77hgyqd3xjj8ucu3jj9r2krwz6mnzyd80gncr5fxcwlh5rsvzp9px.private,  microcredits: 1000000000000u64.private,  _nonce: 3743508150122274933886887505116667914085733635951652042037409200808870682360group.public}"
```

## Bootstrapping

* Use create-aleo-app to bootstrap a template aleo application

```sh
npm create aleo-app@latest
```

