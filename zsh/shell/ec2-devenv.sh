#!/bin/bash
#
set -e
#------------------------------------------------------------
alias start-dev="aws ec2 start-instances --instance-ids i-0cbcc4df99d018b39"
alias stop-dev="aws ec2 stop-instances --instance-ids i-0cbcc4df99d018b39"
export DEV_SSH_ALIAS=vscode_aws
alias ui-dev="ssh -L 59000:localhost:5901 -C -N -l edmondo ${DEV_SSH_ALIAS}"
alias ssh-dev="ssh ${DEV_SSH_ALIAS}"
