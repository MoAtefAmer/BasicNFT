.PHONY: test

test:;forge test  --match-test ${t} -vvv

devops:;forge install Cyfrin/foundry-devops --no-commit