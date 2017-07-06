#aqui es llamar a un modulo de iam group para cada admin group
module "\"administrators\"" {
    source = "\"../modules/aws/identity/iam/administrators\""
}
