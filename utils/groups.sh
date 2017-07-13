#!/bin/sh

#aws iam list-policies | jq -j  '.Policies[] | select(.PolicyName | contains("ReadOnly")) | "\"", .PolicyName, "\","' >> groups.txt

aws --profile aguamala.terraform iam list-policies | jq -j  '.Policies[] | select(.PolicyName | contains("ReadOnly")) | "\"", .PolicyName, "\","' >> groups.txt
