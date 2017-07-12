#!/bin/sh

list=($(aws iam list-policies | jq -r  '.Policies[] | select(.PolicyName | contains("ReadOnly")) | .Arn'))

for arn in ${list[@]}; do
  aws iam get-policy --policy-arn ${arn} | jq -j '.[] | "\"", .PolicyName, "\"", " = ", "\"" ,.Description, "\"\n"' >> descriptions.txt
done
