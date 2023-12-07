include .env

.PHONY: all test clean deploy fund help install snapshot format anvil script deployMood

DEFAULT_ANVIL_KEY := 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d

# help:
# 	@echo "Usage:"
# 	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
# 	@echo ""
# 	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

# all: clean remove install update build

# # Clean the repo
# clean  :; forge clean

# # Remove modules
# remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

# install :; forge install Cyfrin/foundry-devops@0.1.0 --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit

# # Update Dependencies
# update:; forge update

# build:; forge build

# tests :; forge test 

# snapshot :; forge snapshot

# format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key ${DEFAULT_ANVIL_KEY} --broadcast -vvv

ifeq ($(findstring sepolia,${ARGS}),sepolia)
	NETWORK_ARGS:= --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY} --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv
endif


deploy:
	@forge script script/DeployBasicNFT.s.sol:DeployBasicNFT ${NETWORK_ARGS}
	@echo ${SEPOLIA_RPC_URL}
	@echo ${PRIVATE_KEY}
	@echo ${ETHERSCAN_API_KEY}

mint:
	@forge script script/Interactions.s.sol:MintBasicNFT ${NETWORK_ARGS}

# deployMood:
# 	@forge script script/DeployMoodNFT.s.sol:DeployMoodNFT $(NETWORK_ARGS)

# mintMoodNFT:
# 	@forge script script/Interactions.s.sol:MintMoodNFT $(NETWORK_ARGS)

# flipMoodNFT:
# 	@forge script script/Interactions.s.sol:FlipMoodNFT $(NETWORK_ARGS)

test:;forge test  --match-test ${t} -vvv

# devops:;forge install Cyfrin/foundry-devops --no-commit

script:;forge script script/${s}

deployMood:
	@forge script script/DeployMoodNFT.s.sol:DeployMoodNFT $(NETWORK_ARGS)

mintMoodNft:
	@forge script script/Interactions.s.sol:MintMoodNft $(NETWORK_ARGS)

flipMoodNft:
	@forge script script/Interactions.s.sol:FlipMoodNft $(NETWORK_ARGS)

	# mint NFT cast send 0x948B3c65b89DF0B4894ABE91E6D02FE579834F8F "mintNFT()" --private-key ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80 --rpc-url http://localhost:8545