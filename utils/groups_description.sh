#!/bin/sh

#list=($(aws iam list-policies | jq -r  '.Policies[] | select(.PolicyName | contains("ReadOnly")) | .Arn'))
list=($(aws --profile aguamala.terraform iam list-policies | jq -r  '.Policies[] | .Arn'))

for arn in ${list[@]}; do
  aws --profile aguamala.terraform iam get-policy --policy-arn ${arn} | jq -j '.[] | "\"", .PolicyName, "\"", " = ", "\"" ,.Description, "\"\n"' >> descriptions.txt
done
