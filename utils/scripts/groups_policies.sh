#!/bin/sh

#aws iam list-policies | jq -j  '.Policies[] | select(.PolicyName | contains("ReadOnly")) | "\"", .PolicyName, "\"", " = ", "\"" ,.Arn, "\"\n"' >> policies.txt

aws --profile aguamala.terraform iam list-policies | jq -j  '.Policies[] | "\"", .PolicyName, "\"", " = ", "\"" ,.Arn, "\"\n"' >> policies.txt
