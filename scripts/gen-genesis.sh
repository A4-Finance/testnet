#!/bin/bash
readonly A4_HOME="/tmp/a4$(date +%s)"
readonly DEAMON="a4chaind"
readonly DENOM="baseta4"
readonly CHAIN_ID="afour_655-1"

echo "...........Init A4 Chain.............."

./${DEAMON} init --chain-id ${CHAIN_ID} validator --home ${A4_HOME}

echo "..........Prepare genesis......."
cp ${CHAIN_ID}/genesis_prelaunch.json ${A4_HOME}/config/genesis.json

echo "..........Collecting gentxs......."
./${DEAMON} collect-gentxs --home ${A4_HOME} --gentx-dir ${CHAIN_ID}/gen-tx

./${DEAMON} validate-genesis --home $A4_HOME

cp ${A4_HOME}/config/genesis.json ${CHAIN_ID}/genesis.json
jq -S -c -M '' ${CHAIN_ID}/genesis.json | shasum -a 256 > ${CHAIN_ID}/checksum.txt