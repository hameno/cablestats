#!/bin/bash

# Load configuration
source ./config.sh
# Constants
source ./constants.sh

/bin/bash ${BASE_DIR}/gen_singles.sh
/bin/bash ${BASE_DIR}/gen_combined.sh
/bin/bash ${BASE_DIR}/gen_lower.sh
/bin/bash ${BASE_DIR}/gen_upper.sh
#/bin/bash ${BASE_DIR}/publish.sh
