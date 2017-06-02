#!/bin/bash

# Usage: ./init.sh once to initialize remote storage for this environment.
# Subsequent tf actions in this environment don't require re-initialization,
# unless you have completely cleared your .terraform cache.

terraform remote config -backend=s3 \\
                        -backend-config=bucket=${tf_state_bucket} \\
                        -backend-config=key=${tf_state_key} \\
                        -backend-config=region=${tf_state_aws_region} \\
                        -backend-config=profile=${tf_state_aws_profile}

echo set remote s3 state to ${tf_state_key}
