# Terraform tutorial

## JSON and strings

see main.tf

Command:

    terraform apply && terraform output foo | jq

Output:

    [
        {
            "name": "wordpress",
            "environment": [
                {
                    "name": "Hallo",
                    "value": "Edgar \"Willi\" Wuff"
                },
                {
                    "name": "hello",
                    "value": "world"
                }
            ],
            "better_environment": [
                {
                    "name": "Hallo",
                    "value": "Edgar \"Willi\" Wuff"
                },
                {
                    "name": "hello",
                    "value": "world"
                }
            ]
        }
    ]
