#!/bin/sh

aws iam list-policies | jq -j  '.Policies[] | select(.PolicyName | contains("ReadOnly")) | "\"", .PolicyName, "\","' >> groups.txt
