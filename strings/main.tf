variable "alist" {
  type = list
  default = [
      {name = "Hallo", value="Edgar \"Willi\" Wuff"},
      {name = "hello", value="world"},
    ]
}

data "template_file" "example" {
  template = <<EOT
[
    {
      "name": "wordpress",
      "environment": [
        %{ for i, item in var.alist ~}
          {
            "name": ${jsonencode(item.name)},
            "value": ${jsonencode(item.value)}
          }
          %{if i < length(var.alist)-1 ~}
            ,
          %{endif ~}
        %{ endfor ~}       
      ],
      "better_environment" : ${jsonencode(var.alist)}
    }
]
EOT
}

output "foo" {
    value = data.template_file.example.rendered
}
