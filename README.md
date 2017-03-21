# Convenience scripts for AWS SDK Ruby

Requirements

- Ruby
- AWS SDK (configured for your account)

The AWS SDK is pretty low-level, here are some helpers to get access to info quicker and not resort to going through the web console.

1. aws_list_instances - Lists all EC2 instances that are not 'stopped'

I would recommend cloning this repo, then making some aliases (in ~/.bashrc) for easy access.

`alias aws_list_instances='ruby /whatever_path/aws_list_instances.rb'`