#!/bin/bash
readonly A4_HOME="/tmp/a4$(date +%s)"
readonly DEAMON="a4chaind"
readonly DENOM="baseta4"
readonly CHAIN_ID="afour_655-1"

readonly ACCOUNTS=$1

./${DEAMON} init --chain-id ${CHAIN_ID} validator --home ${A4_HOME}

while read -r addr value; do
  ./${DEAMON} --home ${A4_HOME} add-genesis-account ${addr} ${value}${DENOM}
done < ${ACCOUNTS}

cp ${A4_HOME}/config/genesis.json ../${CHAIN_ID}/genesis_prelounch.json