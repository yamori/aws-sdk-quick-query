# Convenience scripts for AWS SDK Ruby

The AWS SDK is pretty low-level, here are some helpers to get access to info quicker and not resort to going through the web console.

Sample output:

```vagrant@precise64:/vagrant$ aws_list_instances
...Querying AWS us-east-1
====================
Jenkins_rhel   status:running   t2.medium     id:i-123456789   vpc:vpc-123
  Pub IP: 123.123.456.789
  Prv IP: 10.0.0.123
  Inbound-tcp: [22, 80, 443, 3389, 4444, 5555, 8080, 8081, 10000, 10001, 10002]
====================
Selenium_hub_win   status:running   t2.micro     id:i-123456780   vpc:vpc-123
  Pub IP: 123.123.456.780
  Prv IP: 10.0.0.124
  Inbound-tcp: [22, 80, 443, 8081, 10000, 10001, 10002]
====================```

## Requirements

- Ruby (highly recommend [rvm](https://rvm.io/))
  - gems: aws-sdk
- AWS CLI (configured for your account)

## Scripts

1. aws_list_instances - Lists all EC2 instances that are not 'stopped'

## Install

I would recommend cloning this repo, then making some aliases (in ~/.bashrc) for easy access.

`alias aws_list_instances='ruby /whatever_path/aws_list_instances.rb'`