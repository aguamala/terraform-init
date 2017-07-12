
resource "\"aws_iam_policy\"" "\"${domain}_networking_vpc_fullacess\"" {
  name   = "\"${domain}_networking_vpc_fullaccess\""
  policy = "\"\$\{data.aws_iam_policy_document.${domain}_networking_vpc_fullaccess.json\}\""
}

data "\"aws_iam_policy_document\"" "\"${domain}_networking_vpc_fullaccess\"" {
  statement {
    sid = "\"1\""

    actions = [
      "\"vpc:*\"",
    ]

    condition {
      test     = "\"StringEquals\""
      variable = "\"ec2:Vpc\""

      values = [
        "\"arn:aws:ec2:region:account:vpc/\$\{module.${domain}_vpc.id\}\"",
      ]
    }

    resources = [
      "\"*\"",
    ]
  }
}


resource "\"aws_iam_policy\"" "\"${domain}_networking_vpc_readonlyaccess\"" {
  name   = "\"${domain}_networking_vpc_readonlyaccess\""
  policy = "\"\$\{data.aws_iam_policy_document.${domain}_networking_vpc_readonlyaccess.json\}\""
}

data "\"aws_iam_policy_document\"" "\"${domain}_networking_vpc_readonlyaccess\"" {
  statement {
    sid = "\"1\""

    actions = [
      "\"ec2:DescribeAddresses\"",
      "\"ec2:DescribeClassicLinkInstances\"",
      "\"ec2:DescribeCustomerGateways\"",
      "\"ec2:DescribeDhcpOptions\"",
      "\"ec2:DescribeFlowLogs\"",
      "\"ec2:DescribeInternetGateways\"",
      "\"ec2:DescribeMovingAddresses\"",
      "\"ec2:DescribeNatGateways\"",
      "\"ec2:DescribeNetworkAcls\"",
      "\"ec2:DescribeNetworkInterfaceAttribute\"",
      "\"ec2:DescribeNetworkInterfaces\"",
      "\"ec2:DescribePrefixLists\"",
      "\"ec2:DescribeRouteTables\"",
      "\"ec2:DescribeSecurityGroups\"",
      "\"ec2:DescribeSubnets\"",
      "\"ec2:DescribeTags\"",
      "\"ec2:DescribeVpcAttribute\"",
      "\"ec2:DescribeVpcClassicLink\"",
      "\"ec2:DescribeVpcEndpoints\"",
      "\"ec2:DescribeVpcEndpointServices\"",
      "\"ec2:DescribeVpcPeeringConnections\"",
      "\"ec2:DescribeVpcs\"",
      "\"ec2:DescribeVpnConnections\"",
      "\"ec2:DescribeVpnGateways\""
    ]

    condition {
      test     = "\"StringEquals\""
      variable = "\"ec2:Vpc\""

      values = [
        "\"arn:aws:ec2:region:account:vpc/\$\{module.${domain}_vpc.id\}\"",
      ]
    }

    resources = [
      "\"*\"",
    ]
  }
}
