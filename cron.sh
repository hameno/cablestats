#!/bin/bash

# Load configuration
source ./config.sh
# Constants
source ./constants.sh

sh ${BASE_DIR}/gen_singles.sh
sh ${BASE_DIR}/gen_combined.sh
sh ${BASE_DIR}/gen_lower.sh
sh ${BASE_DIR}/gen_upper.sh
#sh ${BASE_DIR}/publish.sh
