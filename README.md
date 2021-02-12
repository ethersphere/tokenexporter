# TOKENexporter

This project is a fork from [hunterlong/tokenexporter](https://github.com/hunterlong/tokenexporter)

A lightweight Prometheus exporter that will output ERC20 Token balances from a list of addresses you specify. TOKENexporter attaches to a geth server to fetch token wallet balances for your Grafana dashboards. You can also use [ETHexporter](https://github.com/ethersphere/ethexporter) for Ethereum balances.

## watch addresses
The `addresses.txt` file holds all the addresses to fetch balances for. Use the format `name:address` on each new line.
```
etherdelta:0x8d12A197cB00D4747a1fe03395095ce2A5CC6819
bittrex:0xFBb1b73C4f0BDa4f67dcA266ce6Ef42f520fBB98
```

## list of all ERC20 token addresses
TOKENexporter uses [ethTokens.json](https://github.com/kvhnuke/etherwallet/blob/mercury/app/scripts/tokens/ethTokens.json) to get all the ERC20 contract addresses that your account may be holding.

## build docker image
Clone this repo and then follow the simple steps below!

### build docker image
`docker build -t tokenexporter:latest .`

### Run tokenexporter
You'll need access to an ethereum Geth server to fetch balances. You can use [Infura.io](https://infura.io/setup) or [Slock.it](https://rpc.slock.it/).
```
docker run -d -p 9891:9891 \
 -e GETH="https://rpc.slock.it/goerli" \
 ethersphere/tokenexporter:latest
```

## pull from dockerhub
Create a `addresses.txt` file with the correct format mentioned above.
```
docker run -d -v $(pwd)/addresses.txt:/app/addresses.txt \
 -p 9891:9891 \
 -e GETH=https://rpc.slock.it/goerli \
 ethersphere/tokenexporter:latest
```
The Docker image should be running with the default addresses.

## /metrics response
```
token_balance{name="etherdelta",symbol="$TEAK",contract="0x7dd7f56d697cc0f2b52bd55c057f378f1fe6ab4b",address="0x8d12A197cB00D4747a1fe03395095ce2A5CC6819"} 0
token_balance{name="etherdelta",symbol="1ST",contract="0xAf30D2a7E90d7DC361c8C4585e9BB7D2F6f15bc7",address="0x8d12A197cB00D4747a1fe03395095ce2A5CC6819"} 385205.953499985641501145
.
.
.
token_balance{name="etherdelta",symbol="onG",contract="0xd341d1680eeee3255b8c4c75bcce7eb57f144dae",address="0x8d12A197cB00D4747a1fe03395095ce2A5CC6819"} 509226.564895201084026963
token_balance{name="etherdelta",symbol="YEED",contract="0x6f7a4bac3315b5082f793161a22e26666d22717f",address="0x8d12A197cB00D4747a1fe03395095ce2A5CC6819"} 0
token_query_seconds{name="all"} 10.037673145
```
